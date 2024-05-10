{ config, ... }:
{
  services.unbound = {
    enable = true;
    settings = {
      server = {
        qname-minimisation = "yes";
        interface = "0.0.0.0";
        access-control = [
          "192.168.0.0/24 allow"
          "10.100.0.0/24 allow"
        ];
        local-zone = [
          "\"pp.comfycamp.space\" static"
          "\"vault.comfycamp.space\" static"
        ];
        local-data = [
          "\"pp.comfycamp.space IN A 10.100.0.1\""
          "\"vault.comfycamp.space IN A 10.100.0.1\""
        ];
      };
      forward-zone = [
        {
          name = ".";
          forward-addr = [
            "1.1.1.1"
            "8.8.8.8"
          ];
        }
      ];
    };
  };
}
