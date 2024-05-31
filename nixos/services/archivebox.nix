{ config, ... }:
{
  virtualisation.oci-containers.containers.archivebox = {
    autoStart = true;
    image = "mirror.gcr.io/archivebox/archivebox:0.7.2";
    ports = ["56001:8000"];
    volumes = [
      "/hdd/archivebox:/data"
    ];
  };
}
