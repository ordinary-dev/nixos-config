{ config, pkgs, ...}: {
  services.prosody = {
    enable = true;
  
    package = pkgs.prosody.override {
      withExtraLibs = [ pkgs.luajitPackages.luadbi ];
    };

    httpPorts = [ 5280 ];
    httpsPorts = [ 5281 ];

    virtualHosts."xmpp.comfycamp.space" = {
      enabled = true;
      domain = "xmpp.comfycamp.space";
      ssl = {
        cert = "/var/lib/acme/comfycamp.space/fullchain.pem";
        key = "/var/lib/acme/comfycamp.space/key.pem";
      };
    };

    uploadHttp = {
      domain = "upload.comfycamp.space";
      uploadExpireAfter = "60 * 60 * 24 * 7 * 4";
    };

    ssl = {
      cert = "/var/lib/acme/comfycamp.space/fullchain.pem";
      key = "/var/lib/acme/comfycamp.space/key.pem";
    };

    muc = [
      {
        domain = "conference.comfycamp.space";
        maxHistoryMessages = 512;
      }
    ];

    allowRegistration = true;
    admins = [
      "lumin@xmpp.comfycamp.space"
    ];

    extraConfig = ''
      storage = "sql"
      sql = { driver = "PostgreSQL", database = "prosody", username = "prosody", password = "", host = "/run/postgresql" }
    '';
  };
}
