{ config, pkgs, ... }:
{
  config.services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
    ensureDatabases = [ "mastodon" "matrix-synapse" "nextcloud" "maddy" "plausible" "microboard" "freshrss" ];
    ensureUsers = [
      {
        name = "mastodon";
        ensurePermissions = {
          "DATABASE mastodon" = "ALL PRIVILEGES";
        };
        ensureClauses.login = true;
      }
      {
        name = "nextcloud";
        ensurePermissions = {
          "DATABASE nextcloud" = "ALL PRIVILEGES";
        };
        ensureClauses.login = true;
      }
      {
        name = "matrix-synapse";
        ensurePermissions = {
          "DATABASE \"matrix-synapse\"" = "ALL PRIVILEGES";
        };
        ensureClauses.login = true;
      }
      {
        name = "maddy";
        ensurePermissions = {
          "DATABASE maddy" = "ALL PRIVILEGES";
        };
        ensureClauses.login = true;
      }
      {
        name = "plausible";
        ensurePermissions = {
          "DATABASE plausible" = "ALL PRIVILEGES";
        };
        ensureClauses.login = true;
      }
      {
        name = "microboard";
        ensurePermissions = {
          "DATABASE microboard" = "ALL PRIVILEGES";
        };
        ensureClauses.login = true;
      }
      {
        name = "freshrss";
        ensurePermissions = {
          "DATABASE freshrss" = "ALL PRIVILEGES";
        };
        ensureClauses.login = true;
      }
    ];
    initialScript = pkgs.writeText "pg-init.sql" ''
      ALTER DATABASE nextcloud OWNER TO nextcloud;
      ALTER DATABASE mastodon OWNER TO mastodon;
      ALTER DATABASE "matrix-synapse" OWNER TO "matrix-synapse";
      ALTER DATABASE maddy OWNER TO maddy;
      ALTER DATABASE plausible OWNER TO plausible;
      ALTER DATABASE microboard OWNER TO microboard;
      ALTER DATABASE freshrss OWNER TO freshrss;
    '';
    identMap = ''
       # ArbitraryMapName systemUser DBUser
       superuser_map      root       postgres
       superuser_map      postgres   postgres
       
       # Let other names login as themselves
       superuser_map      /^(.*)$    \1
    '';
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method  optional_ident_map
      local sameuser  all     peer         map=superuser_map

      #type database  DBuser  origin-address  auth-method
      host  all       all     127.0.0.1/32    scram-sha-256
    '';
  };
}
