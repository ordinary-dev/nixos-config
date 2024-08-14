{ config, ... }:
{
  virtualisation.oci-containers.containers.comfycamp = {
    autoStart = true;
    image = "git.comfycamp.space/lumin/comfycamp:v0.8.3";
    ports = ["55007:80"];
  };
  virtualisation.oci-containers.containers.comfycamp-beta = {
    autoStart = true;
    image = "git.comfycamp.space/lumin/comfycamp:v1.0.3";
    ports = ["55407:4000"];
    user = "977:971";
    environmentFiles = [
      "/var/lib/comfycamp/.env"
    ];
    volumes = [
      "/run/postgresql:/run/postgresql"
    ];
  };

  services.nginx.virtualHosts."[201:80ed:6eeb:aea4:cdc0:c836:2831:f2dd]" = {
    locations."/".proxyPass = "http://127.0.0.1:55007";
  };

  services.nginx.virtualHosts."comfycamp.space" = {
    useACMEHost = "comfycamp.space";
    forceSSL = true;
    locations."/".proxyPass = "http://127.0.0.1:55007";
  };

  services.nginx.virtualHosts."www.comfycamp.space" = {
    useACMEHost = "comfycamp.space";
    forceSSL = true;
    locations."/".return = "301 https://comfycamp.space$request_uri";
  };

  services.nginx.virtualHosts."beta.comfycamp.space" = {
    useACMEHost = "comfycamp.space";
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:55407";
      proxyWebsockets = true;
    };
  };
}
