{ lib, config, ... }:
let
  cfg = config.lawford.system.flatpak;
in
{
  options.lawford.system.flatpak = {
    enable = lib.mkEnableOption "Enable Flatpak ecosystem";
  };

  config = lib.mkIf cfg.enable {
    services.flatpak.enable = true;
  };
}
