{ config, ... }:
{
  services.yggdrasil = {
    enable = true;
    persistentKeys = true;
    settings = {
      Listen = [
        "tcp://0.0.0.0:16001"
        "tls://0.0.0.0:16002"
      ];
      Peers = [
        "tls://ekb.itrus.su:7992"
        "tls://ygg-msk-1.averyan.ru:8362"
        "tls://188.225.9.167:18227"
        "tls://box.paulll.cc:13338"
        "tls://178.20.41.3:65534"
        "tls://45.95.202.91:65534"
        "tls://185.177.216.199:7891"
      ];
    };
    extraArgs = [
      "-loglevel"
      "warn"
    ];
  };
}
