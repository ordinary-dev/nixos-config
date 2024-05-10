{ config, pkgs, ... }:
{
  networking.nat = {
    enable = true;
    externalInterface = "enp7s0";
    internalInterfaces = [ "wg0" ];
  };

  networking.wireguard.interfaces.wg0 = {
    ips = ["10.100.0.1/24" ];
    listenPort = 51820;

    postSetup = ''
      ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o enp7s0 -j MASQUERADE
    '';
    postShutdown = ''
      ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o enp7s0 -j MASQUERADE
    '';

    privateKeyFile = "/var/lib/wireguard/privkey";

    peers = [
      {
        # laptop
        publicKey = "awAVP/tkl0Z9PKEMTABjIXhblWSGHhIvYjBFp3C7YUk=";
        allowedIPs = [ "10.100.0.2/32" ];
      }
      {
        # phone
        publicKey = "zPUl9jrC8dFaPWKk92btHptEzr09KNgGbdwSfiT7rEM=";
        allowedIPs = [ "10.100.0.3/32" ];
      }
    ];
  };
}
