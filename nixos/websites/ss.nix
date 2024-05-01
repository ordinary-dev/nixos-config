{ config, ... }:
{
  virtualisation.oci-containers.containers.ss = {
    autoStart = true;
    image = "git.comfycamp.space/lumin/summer-squad:v0.0.2";
    ports = ["55020:8080"];
  };

  # This site is not secret.
  services.nginx.virtualHosts."summerqbhooezyv5wg2v7rj3v44ig4o3yl3pziiowgg6ynkqwrhif7id.onion" = {
    locations."/".proxyPass = "http://127.0.0.1:55020";
  };
}
