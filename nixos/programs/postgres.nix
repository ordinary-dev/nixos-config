{ config, pkgs, ... }:
{
  config.services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
    ensureDatabases = [ "mastodon" "synapse" "nextcloud" ];
    ensureUsers = [
      {
        name = "mastodon";
        ensurePermissions = {
          "DATABASE mastodon" = "ALL PRIVILEGES";
        };
        ensureClauses = {
          login = true;
        };
      }
      {
        name = "nextcloud";
        ensurePermissions = {
          "DATABASE nextcloud" = "ALL PRIVILEGES";
        };
        ensureClauses = {
          login = true;
        };
      }
    ];
    identMap = ''
       # ArbitraryMapName systemUser DBUser
       superuser_map      root       postgres
       superuser_map      postgres   postgres
       
       # Let other names login as themselves
       superuser_map      /^(.*)$    \1
    '';
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method optional_ident_map
      local sameuser  all     peer        map=superuser_map
    '';
  };
}
