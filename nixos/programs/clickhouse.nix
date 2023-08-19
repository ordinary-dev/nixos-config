{ config, ... }:
{
  services.clickhouse = {
    enable = true;
  };

  # See https://github.com/NixOS/nixpkgs/pull/186667
  # and https://github.com/plausible/hosting/blob/master/clickhouse/clickhouse-config.xml
  environment.etc = {
    "clickhouse-server/config.d/logging.xml" = {
      text = ''
        <clickhouse>
          <logger>
            <level>warning</level>
          </logger>

          <!-- Stop all the unnecessary logging -->
          <query_thread_log remove="remove"/>
          <query_log remove="remove"/>
          <text_log remove="remove"/>
          <trace_log remove="remove"/>
          <metric_log remove="remove"/>
          <asynchronous_metric_log remove="remove"/>
          <session_log remove="remove"/>
          <part_log remove="remove"/>
        </clickhouse>
      '';
    };
  };
}
