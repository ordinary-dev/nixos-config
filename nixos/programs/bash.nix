{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bash
  ];
  programs.bash = {
    shellAliases = {
      ll = "ls -l";
      vi = "nvim";
      vim = "nvim";
      maddyctl = "sudo -u maddy maddyctl";
    };
  };
}
