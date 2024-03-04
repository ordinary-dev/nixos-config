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
    };
    
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [{
          targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
        }];
      }
    ];
  };
}
