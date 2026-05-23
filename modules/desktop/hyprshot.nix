{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.desktop.hyprshot;
in
{
  options.lawford.desktop.hyprshot = {
    enable = lib.mkEnableOption "Enable hyprshot and notification";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libnotify
      hyprshot
    ];

    environment.sessionVariables = {
      HYPRSHOT_DIR = "$HOME/Pictures/Screenshots";
    };
  };
}
