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

  services.nginx.virtualHosts."grafana.comfycamp.space" = {
    useACMEHost = "comfycamp.space";
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:55010";
      proxyWebsockets = true;
    };
  };
}
