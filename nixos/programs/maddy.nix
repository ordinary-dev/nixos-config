{ config, options, ... }:
{
  services.maddy = {
    enable = true;
    primaryDomain = "comfycamp.space";
    hostname = "mx.comfycamp.space";
    tls = {
      loader = "file";
      certificates = [{
        keyPath = "/var/lib/acme/comfycamp.space/key.pem";
        certPath = "/var/lib/acme/comfycamp.space/fullchain.pem";
      }];
    };
    config = builtins.replaceStrings [
      "imap tcp://0.0.0.0:143"
      "submission tcp://0.0.0.0:587"
      "dsn imapsql.db"
      "dsn credentials.db"
      "driver sqlite3"
    ] [
      "imap tls://0.0.0.0:993 tcp://0.0.0.0:143"
      "submission tls://0.0.0.0:465 tcp://0.0.0.0:587"
      "dsn user=maddy host=/run/postgresql dbname=maddy"
      "dsn user=maddy host=/run/postgresql dbname=maddy"
      "driver postgres"
    ] options.services.maddy.config.default;
  };
}
