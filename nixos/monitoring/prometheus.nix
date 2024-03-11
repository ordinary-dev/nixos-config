{ config, ... }: {
  services.prometheus = {
    enable = true;
    port = 55011;

    exporters = {
      node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
        port = 55012;
      };
      postgres = {
        enable = true;
        port = 55014;
        dataSourceName = "user=postgres-exporter database=postgres-exporter host=/run/postgresql sslmode=disable";
      };
    };
    
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [{
          targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
        }];
      }
      {
        job_name = "synapse";
        metrics_path = "/_synapse/metrics";
        static_configs = [{
          targets = [ "127.0.0.1:55013" ];
        }];
      }
      {
        job_name = "postgres";
        static_configs = [{
          targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.postgres.port}" ];
        }];
      }
    ];
  };
}
