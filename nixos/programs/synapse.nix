{ config, ... }:
{
  services.matrix-synapse = {
    enable = true;
    settings = {
      server_name = "matrix.comfycamp.space";
      public_baseurl = "https://matrix.comfycamp.space";
      database = {
        name = "psycopg2";
        args = {
          user = "matrix-synapse";
          database = "matrix-synapse";
        };
      };
      enable_registration = true;
      report_stats = true;
      listeners = [{
        bind_addresses = [ "127.0.0.1" ];
        port = 8008;
        type = "http";
        tls = false;
        x_forwarded = true;
        resources = [{
          names = [ "client" "federation" ];
          compress = false;
        }];
      }];
      signing_key_path = "/var/lib/matrix-synapse/matrix.comfycamp.space.signing.key";
    };
    extraConfigFiles = [
      "/var/lib/secrets/matrix-synapse/config.yml"
    ];
  };
}
