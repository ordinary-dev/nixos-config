{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./users.nix
    ./time.nix
    
    ./networking/network.nix
    ./networking/unbound.nix
    ./networking/wireguard.nix

    ./databases/postgres.nix
    ./databases/mysql.nix
    ./databases/redis.nix

    ./programs/acme.nix
    ./programs/bash.nix
    ./programs/docker.nix
    ./programs/nginx.nix

    ./monitoring/grafana.nix
    ./monitoring/prometheus.nix
    
    ./services/comfycamp.nix
    ./services/deluge.nix
    ./services/forgejo.nix
    ./services/freshrss.nix
    ./services/jellyfin.nix
    ./services/maddy.nix
    ./services/mastodon.nix
    ./services/microboard.nix
    ./services/nextcloud.nix
    ./services/phoenix.nix
    ./services/photoprism.nix
    ./services/prosody.nix
    ./services/ss.nix
    ./services/synapse.nix
    ./services/yggdrasil.nix
  ];

  nix = {
    # Enable flakes
    settings.experimental-features = [ "nix-command" "flakes" ];
    # Garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
      dates = [ "03:00" ];
    };
  };

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
