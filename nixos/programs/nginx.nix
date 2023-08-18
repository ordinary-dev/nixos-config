{ config, ... }:
{
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;

    virtualHosts = {
      "nc.comfycamp.space" = {
        useACMEHost = "comfycamp.space";
        forceSSL = true;
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
