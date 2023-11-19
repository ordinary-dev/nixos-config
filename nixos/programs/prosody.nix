{ config, ...}: {
  services.prosody = {
    enable = true;
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
  };
}
