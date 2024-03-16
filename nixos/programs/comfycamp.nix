{ config, ... }:
{
  virtualisation.oci-containers.containers.comfycamp = {
    autoStart = true;
    image = "git.comfycamp.space/lumin/comfycamp:v0.8.1";
    ports = ["55007:80"];
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
}
