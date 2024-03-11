{ config, ... }:
{
  virtualisation.oci-containers.containers.phoenix = {
    autoStart = true;
    image = "ghcr.io/ordinary-dev/phoenix:v1.2.0";
    ports = ["55009:8080"];
    user = "984:980";
    environmentFiles = [
      "/var/lib/phoenix/.env"
    ];
    volumes = [
      "/var/lib/phoenix:/var/lib/phoenix"
    ];
  };

  services.nginx.virtualHosts."ph.comfycamp.space" = {
    useACMEHost = "comfycamp.space";
    forceSSL = true;
    locations."/".proxyPass = "http://127.0.0.1:55009";
  };
}
