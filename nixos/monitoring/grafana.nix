{ config, ... }: {
  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 55010;
        domain = "grafana.comfycamp.space";
      };
      database = {
        user = "grafana";
        type = "postgres";
        name = "grafana";
        host = "/var/run/postgresql";
      };
    };
  };

  services.nginx.virtualHosts.${config.services.grafana.settings.server.domain} = {
    useACMEHost = "comfycamp.space";
    forceSSL = true;
    listenAddresses = [
      "10.101.0.1"
    ];
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.grafana.settings.server.http_port}";
      proxyWebsockets = true;
    };
  };
}
