{ config, pkgs, ... }:
{
  users.groups = {
    minecraft = {};
  };
  users.users.minecraft = {
    isNormalUser = true;
    group = "minecraft";
  };
  virtualisation.oci-containers.containers.minecraft = {
    autoStart = true;
    image = "itzg/minecraft-server:stable";
    ports = ["25565:25565"];
    user = "1003:972";
    environment = {
      EULA = "TRUE";
      TYPE = "PAPER";
      VERSION = "1.21";
      DIFFICULTY = "hard";
      ONLINE_MODE = "false";
      SERVER_NAME = "Comfycamp";
      TZ = "Asia/Yekaterinburg";
    };
    volumes = [
      "/var/lib/minecraft:/data"
    ];
  };

  # Backups.
  environment.systemPackages = [
    pkgs.restic
  ];
}
