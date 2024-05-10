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
        
        # Prosody
        5000  # File transfer proxy
        5222  # Client connections
        5223  # Client connections - tls
        5269  # Server-to-server connections
        5270  # Server-to-server connections - tls
        5281  # HTTPS

        6881  # torrents
        16001 # yggdrasil tcp
        16002 # yggdrasil tls
      ];
      allowedUDPPorts = [
        53    # DNS
        1900  # jellyfin
        7359  # jellyfin
        6881  # torrents
        51820 # wireguard
      ];
    };

    wireless.enable = false;
  };
}
