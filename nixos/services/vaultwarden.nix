{ config, ... }:
{
  services.vaultwarden = {
    enable = true;
    dbBackend = "postgresql";
    config = {
      DOMAIN = "https://vault.comfycamp.space";

      DATABASE_URL = "postgresql:///vaultwarden?host=/var/run/postgresql";

      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
      ROCKET_LOG = "warn";
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
    };
  };
}
