{ config, ... }:
{
  # Часовой пояс
  time.timeZone = "Asia/Yekaterinburg";

  # Включить NTP.
  services.timesyncd.enable = true;
}
