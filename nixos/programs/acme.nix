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
      "0ch.space" = {
        dnsProvider = "cloudflare";
        domain = "0ch.space";
        extraDomainNames = [ "*.0ch.space" ];
        dnsPropagationCheck = true;
        credentialsFile = "/var/lib/secrets/cloudflare.txt";
      };
    };
  };
}
