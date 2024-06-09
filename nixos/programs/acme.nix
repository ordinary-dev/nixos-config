{ config, ... }:
{
  # Настройки сервиса для получения wildcard сертификатов.
  # https://nixos.wiki/wiki/ACME
  # https://go-acme.github.io/lego/dns/

  security.acme = {
    acceptTerms = true;
    defaults.email = "ordinarydev@protonmail.com";

    certs = {
      "comfycamp.space" = {
        dnsProvider = "cloudflare";
        domain = "comfycamp.space";
        extraDomainNames = [ "*.comfycamp.space" ];
        dnsPropagationCheck = true;
        credentialsFile = "/var/lib/secrets/cloudflare.txt";
      };
    };
  };
}
