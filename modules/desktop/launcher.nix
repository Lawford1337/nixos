{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.desktop.launcher;
in
{
  options.lawford.desktop.launcher = {
    enable = lib.mkEnableOption "Enable Fuzzel app launcher";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.lawford = {
      programs.fuzzel = {
        enable = true;
        settings = {
          main = {
            terminal = "wezterm";
            layer = "overlay";
          };
        };
      };
    };
  };
}
