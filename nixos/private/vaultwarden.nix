{ config, ... }:
{
  services.vaultwarden = {
    enable = true;
    dbBackend = "postgresql";
    environmentFile = "/var/lib/vaultwarden/.env";
    config = {
      DOMAIN = "https://vault.comfycamp.space";

      DATABASE_URL = "postgresql:///vaultwarden?host=/var/run/postgresql";

      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
      ROCKET_LOG = "warn";


      SMTP_HOST = "comfycamp.space";
      SMTP_PORT = 465;
      SMTP_SECURITY = "force_tls";

      SMTP_FROM = "vaultwarden@comfycamp.space";
      SMTP_FROM_NAME = "Vaultwarden";

      SMTP_USERNAME = "vaultwarden@comfycamp.space";
    };
  };

  services.nginx.virtualHosts."vault.comfycamp.space" = {
    useACMEHost = "comfycamp.space";
    forceSSL = true;
    listenAddresses = [
      "10.100.0.1"
    ];
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
      proxyWebsockets = true;
    };
  };
}
