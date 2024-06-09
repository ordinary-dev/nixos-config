{
  description = "flake for comfycamp.space";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.05";
    };
  };

  outputs = inputs @ { self, nixpkgs, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      comfycamp = lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };
  };
}
