{ config, ... }:
{
  # For emergency updates:
  # nixpkgs.overlays = [
  #   (final: prev:
  #      rec {
  #        mastodon = prev.mastodon.override {
  #          version = "4.2.7";
  #          gemset = builtins.toString (final.fetchurl {
  #            url = "https://raw.githubusercontent.com/NixOS/nixpkgs/61acce0cb596050f5fa1c6ebf3f339a893361028/pkgs/servers/mastodon/gemset.nix";
  #            hash = "sha256-Npny6jwon/xdTMU7xOZSZmiwId5IMDUgno1dG1FGkhA=";
  #          });
  #          patches = [
  #            (final.fetchpatch {
  #              url = "https://github.com/mastodon/mastodon/compare/v4.2.6...v4.2.7.patch";
  #              hash = "sha256-8FhlSIHOKIEjq62+rp8QdHY87qMCtDZwjyR0HabdHig=";
  #            })
  #          ];
  #        };
  #      })
  # ];

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

  services.nginx.virtualHosts."m.comfycamp.space" = {
    useACMEHost = "comfycamp.space";
    forceSSL = true;

    root = "${config.services.mastodon.package}/public/";

    locations = {
      "/system/" = {
        alias = "/var/lib/mastodon/public-system/";
      };

      "/" = {
        tryFiles = "$uri @proxy";
      };

      "@proxy" = {
        proxyPass = "http://unix:/run/mastodon-web/web.socket";
        proxyWebsockets = true;
      };

      "/api/v1/streaming/" = {
        proxyPass = "http://unix:/run/mastodon-streaming/streaming.socket";
        proxyWebsockets = true;
      };
    };
  };
}
