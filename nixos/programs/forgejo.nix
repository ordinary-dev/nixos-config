{ config, ... }:
{
  services.forgejo = {
    enable = true;
    settings = {
      session.COOKIE_SECURE = true;
      server = {
        ROOT_URL = "https://git.comfycamp.space";
        PROTOCOL = "http+unix";
        DOMAIN = "git.comfycamp.space";
      };
      log.LEVEL = "Warn";
      mailer = {
        ENABLED = true;
        PROTOCOL = "smtps";
        SMTP_ADDR = "comfycamp.space";
        SMTP_PORT = 465;
        USER = "forgejo@comfycamp.space";
      };
    };
    mailerPasswordFile = "/var/lib/secrets/forgejo/mail.txt";
    database = {
      type = "postgres";
      socket = "/run/postgresql";
    };
  };
  services.nginx.virtualHosts."git.comfycamp.space" = {
    useACMEHost = "comfycamp.space";
    forceSSL = true;
    locations."/" = {
      proxyPass = "http://unix:${config.services.forgejo.settings.server.HTTP_ADDR}";
    };
  };
}
