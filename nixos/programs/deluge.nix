{ config, ... }:
{
  services.deluge = {
    enable = true;
    web.enable = false;
  };
}
