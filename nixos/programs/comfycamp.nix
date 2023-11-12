{ config, ... }:
{
  virtualisation.oci-containers.containers.comfycamp = {
    autoStart = true;
    image = "ghcr.io/ordinary-dev/comfycamp:v0.3.0";
    ports = ["55007:80"];
  };
}
