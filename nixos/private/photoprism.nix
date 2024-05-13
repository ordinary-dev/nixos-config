{ config, ... }:
{
  services.photoprism = {
    enable = true;
    address = "127.0.0.1";
    originalsPath = "/hdd/photoprism-originals";
    port = 55004;
    settings = {
      PHOTOPRISM_DATABASE_DRIVER = "mysql";
      PHOTOPRISM_DATABASE_NAME = "photoprism";
      PHOTOPRISM_DATABASE_USER = "photoprism";
      PHOTOPRISM_DATABASE_SERVER = "/run/mysqld/mysqld.sock";
      
      PHOTOPRISM_AUTH_MODE = "password";
      PHOTOPRISM_SITE_URL = "https://pp.comfycamp.space";
      PHOTOPRISM_LOG_LEVEL = "warning";
      PHOTOPRISM_READONLY = "false";
      PHOTOPRISM_EXPERIMENTAL = "false";
      PHOTOPRISM_DISABLE_WEBDAV = "true";
      PHOTOPRISM_DISABLE_FACES = "true";
      PHOTOPRISM_DETECT_NSFW = "false";
    };
  };

  services.nginx.virtualHosts."pp.comfycamp.space" = {
    useACMEHost = "comfycamp.space";
    forceSSL = true;
    listenAddresses = [
      "10.101.0.1"
    ];
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.photoprism.port}";
      proxyWebsockets = true;
    };
  };
}
