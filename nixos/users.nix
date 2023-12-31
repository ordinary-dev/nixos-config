{ config, pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    lumin = {
      isNormalUser = true;
      extraGroups = [ "wheel" "jellyfin" "photoprism" ];
      packages = with pkgs; [];
      openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDbC39+hMx+JsowHuhI7tQDaG907iVJIY84ztLxdt/2DgPRBVNNhf0k/I/oB7lrLLuMzJnAgEEjBYHbeQqkhjmOE8J+rowXnRBY6uOAK1v12bqwRwCk8nnb4neGiv+TeIQ8uAdySjh5G+mdPbHYTfzw9th24KEQ++oHL2YUZ4kD/C1E337OvJz969qUPQsCOx31Qqo2GTiubJ4Tx4pqo5oBpNQGM1fPbs1/h+K4HV3pgTpEFLIIDe+yvjPJoCibCAYyU0fUf7Ji8kJWQT92eH58fH+VL7epfAfsaSwiqmMVJU7ORVOPYkZdpdXF87rakEydgdIVcTcttuRjKWoO4EDMYq/b1M9t+fa2lCTA+7TIBlrvjQzGUwrXIdvwBCKRiupZF/Jkz+YH104+sxc1DwxGe+BWzGTuH89ArElGQGpPoh01O7rlzaY1GpecM+ljpd3ra8hE+eJ212rBLVnANZhf/9AYEwnw2cBSi9n1xhJ05VqCHUELPfgiwANP/hLCxLM= lumin@thinkpad" ];
    };
    maddy = {
      isSystemUser = true;
      group = "maddy";
      extraGroups = [ "acme" ];
    };
    prosody = {
      isSystemUser = true;
      group = "prosody";
      extraGroups = [ "acme" ];
    };
    nextcloud = {
      isSystemUser = true;
      group = "nextcloud";
    };
    photoprism = {
      isSystemUser = true;
      group = "photoprism";
    };
    matrix-synapse = {
      isSystemUser = true;
      group = "matrix-synapse";
    };
    plausible = {
      isSystemUser = true;
      group = "plausible";
    };
    microboard = {
      isSystemUser = true;
      group = "microboard";
    };
    freshrss = {
      isSystemUser = true;
      group = "freshrss";
    };
    phoenix = {
      isSystemUser = true;
      group = "phoenix";
    };
  };

  users.groups = {
    mastodon.members = [ "mastodon" config.services.nginx.user ];
    nextcloud.members = [ "nextcloud" config.services.nginx.user ];
    prosody = {};
    photoprism = {};
    matrix-synapse = {};
    maddy = {};
    plausible = {};
    microboard = {};
    freshrss = {};
    phoenix = {};
  };
}
