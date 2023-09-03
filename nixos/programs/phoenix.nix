{ config, ... }:
{
  virtualisation.oci-containers.containers.phoenix = {
    autoStart = true;
    image = "ghcr.io/ordinary-dev/phoenix:v1.0.1";
    ports = ["55008:80"];
    volumes = [
      "/var/lib/phoenix/:/var/lib/phoenix"
    ];
  };
}
