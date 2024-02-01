{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./users.nix
    ./time.nix
    ./programs/nginx.nix
    ./programs/bash.nix
    ./programs/acme.nix
    ./programs/postgres.nix
    ./programs/mastodon.nix
    ./programs/redis.nix
    ./programs/nextcloud.nix
    ./programs/jellyfin.nix
    ./programs/mysql.nix
    ./programs/photoprism.nix
    ./programs/synapse.nix
    ./programs/fail2ban.nix
    ./programs/maddy.nix
    ./programs/plausible.nix
    ./programs/clickhouse.nix
    ./programs/docker.nix
    ./programs/microboard.nix
    ./programs/freshrss.nix
    ./programs/comfycamp.nix
    ./programs/phoenix.nix
    ./programs/deluge.nix
    ./programs/adguard.nix
    ./programs/prosody.nix
    ./programs/yggdrasil.nix
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
    vips
    go
    pkg-config
    deluged
  ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  powerManagement.powertop.enable = true;

  system.stateVersion = "22.11";
}
