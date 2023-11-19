{ config, ... }: {
  services.adguardhome = {
    enable = true;
    mutableSettings = true;
    settings.bind_port = 55010;
  };
}
