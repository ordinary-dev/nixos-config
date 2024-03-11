{ config, ... }:
{
  services.redis = {
    servers = {
      mastodon = {
        enable = true;
        port = 6379;
        save = [];
        user = "mastodon";
      };
    };
  };
}
