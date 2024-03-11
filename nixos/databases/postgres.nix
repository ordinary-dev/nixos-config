{ config, pkgs, ... }:
{
  config.services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
    ensureDatabases = [
      "mastodon"
      "matrix-synapse"
      "nextcloud"
      "maddy"
      "plausible"
      "microboard"
      "freshrss"
      "prosody"
      "grafana"
    ];
    ensureUsers = [
      {
        name = "mastodon";
        ensureDBOwnership = true;
        ensureClauses.login = true;
      }
      {
        name = "nextcloud";
        ensureDBOwnership = true;
        ensureClauses.login = true;
      }
      {
        name = "matrix-synapse";
        ensureDBOwnership = true;
        ensureClauses.login = true;
      }
      {
        name = "maddy";
        ensureDBOwnership = true;
        ensureClauses.login = true;
      }
      {
        name = "plausible";
        ensureDBOwnership = true;
        ensureClauses.login = true;
      }
      {
        name = "microboard";
        ensureDBOwnership = true;
        ensureClauses.login = true;
      }
      {
        name = "freshrss";
        ensureDBOwnership = true;
        ensureClauses.login = true;
      }
      {
        name = "prosody";
        ensureDBOwnership = true;
        ensureClauses.login = true;
      }
      {
        name = "grafana";
        ensureDBOwnership = true;
        ensureClauses.login = true;
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
      #type database  DBuser  auth-method  optional_ident_map
      local sameuser  all     peer         map=superuser_map

      #type database  DBuser  origin-address  auth-method
      host  all       all     127.0.0.1/32    scram-sha-256
    '';
  };
}
