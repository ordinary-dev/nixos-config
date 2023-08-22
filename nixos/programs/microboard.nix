{ config, ... }:
let
  dataDir = "/var/lib/microboard";
in
{
  virtualisation.oci-containers.containers.microboard = {
    autoStart = true;
    image = "ghcr.io/ordinary-dev/microboard:v0.0.4";
    ports = ["55006:8000"];
    user = "986:983";
    volumes = [
      "/hdd/microboard/.env:/app/.env"
      "/hdd/microboard/uploads:/app/uploads"
      "/hdd/microboard/previews:/app/previews"
      "/run/postgresql:/run/postgresql"
    ];
  };
}
