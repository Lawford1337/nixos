{ lib, config, ... }:
let
  cfg = config.lawford.system.dnsmasq;
in
{
  options.lawford.system.dnsmasq = {
    enable = lib.mkEnableOption "Enable local DNS caching with dnsmasq";
  };
  config = lib.mkIf cfg.enable {
    services.resolved.enable = false;
    services.dnsmasq = {
      enable = true;
      resolveLocalQueries = true;
      alwaysKeepRunning = true;
      settings = {
        listen-address = [ "127.0.0.1" ];
        bind-interfaces = true;
        server = [
          "94.140.14.14"
          "94.140.15.15"
          "1.1.1.1"
          "1.0.0.1"
        ];

        cache-size = 10000;
        min-cache-ttl = 500;
        #max-cache-ttl = 86400;

        dns-forward-max = 1000;

        domain-needed = true;
        bogus-priv = true;
        localise-queries = true;
      };
    };
    networking.nameservers = [ "127.0.0.1" ];
  };
}
