{ config, lib, ... }:
{
  services.plausible = {
    enable = true;
    database.postgres = {
      setup = false;
      dbname = "plausible";
    };
    database.clickhouse = {
      setup = false;
      url = "http://localhost:8123/plausible";
    };
    server = {
      baseUrl = "https://plausible.comfycamp.space";
      port = 55005;
      secretKeybaseFile = "/var/lib/secrets/plausible/keybase.txt";
    };
    adminUser = {
      name = "lumin";
      email = "lumin@comfycamp.space";
      passwordFile = "/var/lib/secrets/plausible/admin-pass.txt";
    };
    mail = {
      email = "plausible@comfycamp.space";
      smtp = {
        enableSSL = true;
        hostAddr = "comfycamp.space";
        hostPort = 465;
        passwordFile = "/var/lib/secrets/plausible/smtp-pass.txt";
        user = "plausible@comfycamp.space";
      };
    };
  };

  systemd.services.plausible.script = lib.mkForce ''
    export CONFIG_DIR=$CREDENTIALS_DIRECTORY

    export RELEASE_COOKIE="$(< $CREDENTIALS_DIRECTORY/RELEASE_COOKIE )"

    # Do not create the database.
    # https://github.com/plausible/analytics/issues/405
    # ${config.services.plausible.package}/createdb.sh

    ${config.services.plausible.package}/migrate.sh
    
    exec plausible start
  '';
}
