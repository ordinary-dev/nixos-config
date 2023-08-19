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
        </clickhouse>
      '';
    };
  };
}
