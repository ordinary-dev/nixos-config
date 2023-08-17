{ config, ... }:
{
  networking = {
    hostName = "comfycamp";

    dhcpcd.enable = true;
    defaultGateway = "192.168.0.1";
    nameservers = [ "1.1.1.1" ];

    firewall = {
      # TODO: enable me
      enable = false;
      allowedTCPPorts = [ 22 80 443 1900 7359 30000 30025 30465 30993 ];
      allowedUDPPorts = [ 30000 1900 7359 ];

      # Kubernetes
      trustedInterfaces = [ "lo" "flannel.1" "cni0" ];
    };

    wireless.enable = false;
  };
}
