{ config, ... }:
let
  dataDir = "/var/lib/microboard";
in
{
  systemd.services.microboard = {
    description = "Microboard engine";
    wantedBy = ["multi-user.target"];

    environment = {
      MB_LOGLEVEL = "warning";
      MB_UPLOADDIR = "${ dataDir }/uploads";
      MB_PREVIEWDIR = "${ dataDir }/previews";
      MB_DBHOST = "/run/postgresql";
      MB_DBUSER = "microboard";
      MB_DBNAME = "microboard";
    };

    serviceConfig = {
      User = "microboard";
      Group = "microboard";
      ExecStart = "${ dataDir }/microboard";
      Restart = "on-failure";
      Type = "exec";
      WorkingDirectory = dataDir;

      # Security Hardening
      LockPersonality = true;
      NoNewPrivileges = true;
      ProtectSystem = "strict";
      ReadWritePaths = [ dataDir ];
      RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
      RestrictSUIDSGID = true;
    };
  };
}
