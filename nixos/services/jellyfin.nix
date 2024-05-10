{ config, pkgs, ... }:
{
  services.jellyfin = {
    enable = true;
  };

  services.nginx.virtualHosts."jf.comfycamp.space" = {
    useACMEHost = "comfycamp.space";
    forceSSL = true;
    locations = {
      "/" = {
        proxyPass = "http://127.0.0.1:8096";
        proxyWebsockets = true;
      };
    };
  };
}
