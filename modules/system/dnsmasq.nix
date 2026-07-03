{ lib, config, ... }:
let
  cfg = config.lawford.system.dnsmasq;
in
{
  options.lawford.system.dnsmasq = {
    enable = lib.mkEnableOption "Enable local DNS caching with dnsmasq";
  };

  config = lib.mkIf cfg.enable {
    services.dnsmasq = {
      enable = true;
      resolveLocalQueries = true;
      alwaysKeepRunning = true;
      settings = {
        # Внешние DNS-серверы (AdGuard и Cloudflare)
        server = [
          "94.140.14.14"
          "94.140.15.15"
          "1.1.1.1"
          "1.0.0.1"
          # "192.168.1.1" # Раскомментируй и впиши IP своего роутера при необходимости
        ];
        
        # Настройки кэширования
        cache-size = 1000;
        min-cache-ttl = 3600;
        max-cache-ttl = 86400;
        
        # Базовая безопасность и оптимизация
        domain-needed = true;
        bogus-priv = true;
        localise-queries = true;
      };
    };

    # Заставляем систему стучаться в наш локальный кэш
    networking.nameservers = [ "127.0.0.1" ];
    
    # Жестко запрещаем NetworkManager'у менять DNS-серверы
    networking.networkmanager.dns = "none";
  };
}
