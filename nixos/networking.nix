{ config, ... }:
{
  networking = {
    hostName = "comfycamp";

    dhcpcd.enable = true;
    defaultGateway = "192.168.0.1";
    nameservers = [ "1.1.1.1" ];

    firewall = {
      enable = true;
      # SSH, nginx
      allowedTCPPorts = [ 22 80 443 ];
      # Jellyfin
      allowedUDPPorts = [ 1900 7359 ];
    };

    wireless.enable = false;
  };
}
