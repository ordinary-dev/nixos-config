{ config, ... }:
let
  dataDir = "/var/lib/microboard";
in
{
  virtualisation.oci-containers.containers.microboard = {
    autoStart = true;
    image = "ghcr.io/ordinary-dev/microboard:v0.0.4";
    environmentFiles = "/var/lib/microboard/.env";
    ports = ["55006:8080"];
    user = "microboard:microboard";
    volumes = [
      "/var/lib/microboard:/app"
      "/run/postgresql:/run/postgresql"
    ];
  };
}
