{ config, pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud27;
    hostName = "nc.comfycamp.space";
    home = "/hdd/nextcloud";
    config = {
      dbtype = "pgsql";
      dbname = "nextcloud";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql";
      overwriteProtocol = "https";
      defaultPhoneRegion = "RU";
      adminuser = "lumin";
      adminpassFile = "/var/lib/secrets/nextcloud/admin-pass.txt";
    };
    configureRedis = true;
    database = {
      createLocally = false;
    };
  };
}
