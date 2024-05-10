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
          "\"comfycamp.lan\" static"
        ];
        local-data = [
          "\"comfycamp.lan IN A 10.100.0.1\""
          "\"vault.comfycamp.lan IN A 10.100.0.1\""
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
