{ config, ... }:
{
  # Настройки сервиса для получения wildcard сертификатов.

  # В /var/lib/secrets/certs.txt находится логин и пароль от reg.ru.
  # REGRU_USERNAME=xxx
  # REGRU_PASSWORD=xxx

  security.acme = {
    acceptTerms = true;
    defaults.email = "ordinarydev@protonmail.com";

    certs = {
      "comfycamp.space" = {
        dnsProvider = "regru";
        domain = "comfycamp.space";
        extraDomainNames = [ "*.comfycamp.space" ];
        dnsPropagationCheck = true;
        credentialsFile = "/var/lib/secrets/certs.txt";
      };
      "0ch.space" = {
        dnsProvider = "regru";
        domain = "0ch.space";
        extraDomainNames = [ "*.0ch.space" ];
        dnsPropagationCheck = true;
        credentialsFile = "/var/lib/secrets/certs.txt";
      };
    };
  };
}
