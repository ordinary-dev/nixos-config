{ config, ... }:
{
  services.freshrss = {
    enable = true;
    database = {
      type = "pgsql";
      host = "127.0.0.1";
      port = 5432;
      passFile = "/var/lib/secrets/freshrss/dbpass.txt";
    };
    baseUrl = "https://freshrss.comfycamp.space";
    defaultUser = "lumin";
    passwordFile = "/var/lib/secrets/freshrss/password.txt";
    virtualHost = "freshrss.comfycamp.space";
  };

  services.nginx.virtualHosts."freshrss.comfycamp.space" = {
    useACMEHost = "comfycamp.space";
    forceSSL = true;
  };
}
