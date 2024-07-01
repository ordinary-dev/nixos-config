{ config, ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [
        "lumin"
        "forgejo"
      ];
    };
    listenAddresses = [
      {
        addr = "10.101.0.1";
        port = 22;
      }
    ];
  };
}
