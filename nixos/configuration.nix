{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./users.nix
    ./fail2ban.nix
    ./time.nix
    ./programs/nginx.nix
    ./programs/bash.nix
    ./programs/acme.nix
    ./programs/postgres.nix
    ./programs/mastodon.nix
    ./programs/redis.nix
  ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    curl
    neovim
    htop
    git
    rsync
    imagemagick
    dig
    iptables
    cryptsetup
    ffmpeg
    file
  ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  system.stateVersion = "22.11";
}
