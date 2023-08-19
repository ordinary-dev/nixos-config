{ config, ... }:
let
  # Required stuff for synapse
  clientConfig."m.homeserver".base_url = "https://matrix.comfycamp.space";
  serverConfig."m.server" = "matrix.comfycamp.space:443";
  mkWellKnown = data: ''
    add_header Content-Type application/json;
    add_header Access-Control-Allow-Origin *;
    return 200 '${builtins.toJSON data}';
  '';
in {
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;

    commonHttpConfig = ''
      # Add HSTS header with preloading to HTTPS requests.
      # Adding this header to HTTP requests is discouraged
      map $scheme $hsts_header {
          https   "max-age=31536000; includeSubdomains; preload";
      }
      add_header Strict-Transport-Security $hsts_header;
    '';

    virtualHosts = {
      "comfycamp.space" = {
        useACMEHost = "comfycamp.space";
        forceSSL = true;
        # This section is not needed if the server_name of matrix-synapse is equal to
        # the domain (i.e. example.org from @foo:example.org) and the federation port
        # is 8448.
        # Further reference can be found in the docs about delegation under
        # https://matrix-org.github.io/synapse/latest/delegate.html
        locations."= /.well-known/matrix/server".extraConfig = mkWellKnown serverConfig;
        # This is usually needed for homeserver discovery (from e.g. other Matrix clients).
        # Further reference can be found in the upstream docs at
        # https://spec.matrix.org/latest/client-server-api/#getwell-knownmatrixclient
        locations."= /.well-known/matrix/client".extraConfig = mkWellKnown clientConfig;
      };

      # Nextcloud
      "nc.comfycamp.space" = {
        useACMEHost = "comfycamp.space";
        forceSSL = true;
      };

      # Jellyfin
      "jf.comfycamp.space" = {
        useACMEHost = "comfycamp.space";
        forceSSL = true;
        locations = {
          "/" = {
            proxyPass = "http://127.0.0.1:8096";
          };
        };
      };

      # Mail: MTA-STS
      "mta-sts.comfycamp.space" = {
        useACMEHost = "comfycamp.space";
        forceSSL = true;
        root = "/var/lib/mta-sts";
      };

      "matrix.comfycamp.space" = {
        useACMEHost = "comfycamp.space";
        forceSSL = true;
        locations = {
          "/".extraConfig = ''
            return 404;
          '';
          # Forward all Matrix API calls to the synapse Matrix homeserver. A trailing slash
          # *must not* be used here.
          "/_matrix".proxyPass = "http://127.0.0.1:8008";
          # Forward requests for e.g. SSO and password-resets.
          "/_synapse/client".proxyPass = "http://127.0.0.1:8008";
        };
      };

      # Photoprism
      "pp.comfycamp.space" = {
        useACMEHost = "comfycamp.space";
        forceSSL = true;
        locations = {
          "/" = {
            proxyPass = "http://127.0.0.1:55004";
            proxyWebsockets = true;
          };
        };
      };

      # Mastodon
      "m.comfycamp.space" = {
        useACMEHost = "comfycamp.space";
        forceSSL = true;

        root = "${config.services.mastodon.package}/public/";

        locations = {
          "/system/" = {
            alias = "/var/lib/mastodon/public-system/";
          };

          "/" = {
            tryFiles = "$uri @proxy";
          };

          "@proxy" = {
            proxyPass = "http://unix:/run/mastodon-web/web.socket";
            proxyWebsockets = true;
          };

          "/api/v1/streaming/" = {
            proxyPass = "http://unix:/run/mastodon-streaming/streaming.socket";
            proxyWebsockets = true;
          };
        };
      };
    };
  };

  users.users.nginx.extraGroups = [ "acme" ];
}
