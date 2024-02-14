{ config, ... }:
{
  nixpkgs.overlays = [
    (final: prev:
       rec {
         mastodon = prev.mastodon.override {
           version = "4.2.6";
           gemset = builtins.toString (final.fetchurl {
             url = "https://raw.githubusercontent.com/NixOS/nixpkgs/5cd625ed59521004edd40e4547c4843413ff4fce/pkgs/servers/mastodon/gemset.nix";
             hash = "sha256-GqeL/z9LBrxV0nuiMFLIE6/Gg3jhydJxt7N2vr6iZAQ=";
           });
           patches = [
             (final.fetchpatch {
               url = "https://github.com/mastodon/mastodon/compare/v4.2.5...v4.2.6.patch";
               hash = "sha256-ElTQFC73dPTiorVOIRCjuGxV8YuXTqNVbaOvil5KP9k=";
             })
           ];
         };
       })
  ];

  services.mastodon = {
    enable = true;

    database = {
      createLocally = false;
      user = "mastodon";
      name = "mastodon";
      host = "/run/postgresql/";
      passwordFile = "/var/lib/secrets/mastodon/postgres.txt";
    };

    redis = {
      createLocally = false;
      host = "127.0.0.1";
      port = 6379;
    };

    configureNginx = false;
    webPort = 55001;
    sidekiqPort = 55003;

    streamingProcesses = 11;

    vapidPrivateKeyFile = "/var/lib/secrets/mastodon/vapid-private-key.txt";
    vapidPublicKeyFile  = "/var/lib/secrets/mastodon/vapid-public-key.txt";
    secretKeyBaseFile   = "/var/lib/secrets/mastodon/secret-key-base.txt";
    otpSecretFile       = "/var/lib/secrets/mastodon/otp-secret.txt";

    localDomain = "m.comfycamp.space";

    mediaAutoRemove = {
      olderThanDays = 14;
    };

    extraConfig = {
      SMTP_SSL = "true";
      SMTP_ENABLE_STARTTLS_AUTO = "false";
      SMTP_AUTH_METHOD = "plain";
      RAILS_LOG_LEVEL = "warn";
    };

    smtp = {
      host = "comfycamp.space";
      user = "mastodon@comfycamp.space";
      port = 465;
      passwordFile = "/var/lib/secrets/mastodon/smtp-password.txt";
      fromAddress = "mastodon@comfycamp.space";
      createLocally = false;
      authenticate = true;
    };
  };

  systemd.services.mastodon-web = {
    serviceConfig.ReadWritePaths = "/hdd/mastodon-public-system";
  };
  systemd.services.mastodon-sidekiq-all = {
    serviceConfig.ReadWritePaths = "/hdd/mastodon-public-system";
  };
}
