{ config, ... }:
{
  services.deluge = {
    enable = true;
    web = {
      enable = true;
      port = 8112;
    };
  };
  
  services.nginx.virtualHosts."deluge.comfycamp.space" = {
    useACMEHost = "comfycamp.space";
    forceSSL = true;
    listenAddresses = [
      "10.101.0.1"
    ];
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.deluge.web.port}";
      proxyWebsockets = true;
    };
  };
}
