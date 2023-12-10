{ config, ... }:
{
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
    streamingPort = 55002;
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
