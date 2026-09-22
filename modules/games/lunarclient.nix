{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.games.lunarclient;

  # Создаем обертку пакета, внедряющую драйверы Nvidia внутрь окружения Lunar
  fixed-lunarclient = pkgs.lunar-client.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.addDriverRunpath ];
    
    postFixup = (oldAttrs.postFixup or "") + ''
      # Добавляем системные драйверы Nvidia в бинарники внутри FHS окружения
      addDriverRunpath $out/bin/lunarclient
      
      # Перехватываем запуск и внедряем жесткие флаги Chromium
      wrapProgram $out/bin/lunarclient \
        --set --disable-gpu-compositing "1" \
        --set --disable-translucent-decorating "1" \
        --set --opaque-blend "1" \
        --set ELECTRON_DISABLE_SANDBOX "1"
    '';
  });
in
{
  options.lawford.games.lunarclient = {
    enable = lib.mkEnableOption "Enable Lunar Client";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [ "lunar-client" ];

    home-manager.users.lawford = {
      home.packages = [ fixed-lunarclient ];
    };
  };
}

