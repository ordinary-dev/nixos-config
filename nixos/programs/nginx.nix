{ config, ... }:
{
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
      "nc.comfycamp.space" = {
        useACMEHost = "comfycamp.space";
        forceSSL = true;
      };
      "jf.comfycamp.space" = {
        locations = {
          "/" = {
            proxyPass = "http://127.0.0.1:8096";
          };
        };
      };
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
