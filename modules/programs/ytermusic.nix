{ lib, config, pkgs, ... }:
let
  cfg = config.lawford.programs.ytermusic;
in
{
  options.lawford.programs.ytermusic = {
    enable = lib.mkEnableOption "Enable ytermusic YouTube Music TUI client";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.lawford = {
      home.packages = with pkgs; [
        ytermusic
      ];
    };
  };
}
