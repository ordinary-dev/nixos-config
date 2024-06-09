{ config, pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud28;
    hostName = "nc.comfycamp.space";
    home = "/hdd/nextcloud";
    config = {
      dbtype = "pgsql";
      dbname = "nextcloud";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql";
      adminuser = "lumin";
      adminpassFile = "/var/lib/secrets/nextcloud/admin-pass.txt";
    };
    settings = {
      overwriteProtocol = "https";
      defaultPhoneRegion = "RU";
    };
    configureRedis = true;
    database = {
      createLocally = false;
    };
  };

  services.nginx.virtualHosts."nc.comfycamp.space" = {
    useACMEHost = "comfycamp.space";
    forceSSL = true;
  };
}
