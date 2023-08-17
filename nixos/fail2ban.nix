{ config, ... }:
{
  services.fail2ban = {
    enable = false;
    maxretry = 5;
    ignoreIP = [
      "192.168.88.0/24"
    ];
  };
}
