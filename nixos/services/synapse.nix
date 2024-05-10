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
  services.matrix-synapse = {
    enable = true;
    settings = {
      server_name = "matrix.comfycamp.space";
      public_baseurl = "https://matrix.comfycamp.space";
      database = {
        name = "psycopg2";
        args = {
          user = "matrix-synapse";
          database = "matrix-synapse";
        };
      };
      enable_metrics = true;
      enable_registration = true;
      report_stats = true;
      listeners = [
        {
          bind_addresses = [ "127.0.0.1" ];
          port = 8008;
          type = "http";
          tls = false;
          x_forwarded = true;
          resources = [{
            names = [ "client" "federation" ];
            compress = false;
          }];
        }
        {
          bind_addresses = [ "127.0.0.1" ];
          port = 55013;
          type = "metrics";
          tls = false;
          resources = [{
            names = [ "metrics" ];
            compress = false;
          }];
        }
      ];
      signing_key_path = "/var/lib/matrix-synapse/matrix.comfycamp.space.signing.key";
    };
    extraConfigFiles = [
      "/var/lib/secrets/matrix-synapse/config.yml"
    ];
  };

  services.nginx.virtualHosts."matrix.comfycamp.space" = {
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

  # This section is not needed if the server_name of matrix-synapse is equal to
  # the domain (i.e. example.org from @foo:example.org) and the federation port
  # is 8448.
  # Further reference can be found in the docs about delegation under
  # https://matrix-org.github.io/synapse/latest/delegate.html
  services.nginx.virtualHosts."comfycamp.space".locations."/.well-known/matrix/server".extraConfig = mkWellKnown serverConfig;
  # This is usually needed for homeserver discovery (from e.g. other Matrix clients).
  # Further reference can be found in the upstream docs at
  # https://spec.matrix.org/latest/client-server-api/#getwell-knownmatrixclient
  services.nginx.virtualHosts."comfycamp.space".locations."/.well-known/matrix/client".extraConfig = mkWellKnown clientConfig;
}
