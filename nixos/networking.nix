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
        53    # adguard
        80    # nginx
        443   # nginx
        25    # smtp inbound
        465   # smtp submission
        587   # smtp submission
        143   # imap
        993   # imap
        6881  # torrents
        55010 # adguard
      ];
      allowedUDPPorts = [
        53    # adguard
        1900  # jellyfin
        7359  # jellyfin
        6881  # torrents
      ];
    };

    wireless.enable = false;
  };
}
