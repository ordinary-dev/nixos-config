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
      kubectl = "sudo k3s kubectl";
      maddyctl = "sudo -u maddy maddyctl";
    };
  };
}
