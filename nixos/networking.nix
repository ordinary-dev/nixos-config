{ config, ... }:
{
  networking = {
    hostName = "comfycamp";

    dhcpcd.enable = true;
    defaultGateway = "192.168.0.1";
    nameservers = [ "1.1.1.1" ];

    firewall = {
      enable = true;
      allowedTCPPorts = [
        22    # SSH
        80    # nginx
        443   # nginx
        25    # smtp inbound
        465   # smtp submission
        587   # smtp submission
        143   # imap
        993   # imap
      ];
      # Jellyfin
      allowedUDPPorts = [ 1900 7359 ];
    };

    wireless.enable = false;
  };
}
