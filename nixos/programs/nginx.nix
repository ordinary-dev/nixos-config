{ config, ... }:
{
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;

    virtualHosts = {
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
        extraConfig = ''
          # Add HSTS header with preloading to HTTPS requests.
          # Adding this header to HTTP requests is discouraged
          map $scheme $hsts_header {
              https   "max-age=31536000; includeSubdomains; preload";
          }
          add_header Strict-Transport-Security $hsts_header;

          # Minimize information leaked to other domains
          add_header 'Referrer-Policy' 'origin-when-cross-origin';

          # Disable embedding as a frame
          add_header Content-Security-Policy "frame-ancestors 'self' https://*.comfycamp.space;";

          # Prevent injection of code in other mime types (XSS Attacks)
          add_header X-Content-Type-Options nosniff;

          # Enable XSS protection of the browser.
          add_header X-XSS-Protection "1; mode=block";
        '';
      };
    };
  };

  users.users.nginx.extraGroups = [ "acme" ];
}
