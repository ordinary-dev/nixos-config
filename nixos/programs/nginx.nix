{ config, ... }: {
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;

    clientMaxBodySize = "512M";

    commonHttpConfig = ''
      # Add HSTS header with preloading to HTTPS requests.
      # Adding this header to HTTP requests is discouraged
      map $scheme $hsts_header {
          https   "max-age=31536000; includeSubdomains; preload";
      }
      add_header Strict-Transport-Security $hsts_header;
      
      # Log 4xx and 5xx errors.
      map $status $loggable {
          ~^[23]  0;
          default 1;
      }
      access_log /var/log/nginx/access.log combined if=$loggable;

      server_names_hash_bucket_size 128;
    '';
  };

  users.users.nginx.extraGroups = [ "acme" ];
}
