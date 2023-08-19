{ config, ... }:
{
  services.fail2ban = {
    enable = true;
    maxretry = 5;
    ignoreIP = [
      "192.168.0.0/24"
    ];
  };
}
