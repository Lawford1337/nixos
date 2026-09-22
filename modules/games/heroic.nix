{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.games.heroic;
in
{
  options.lawford.games.heroic = {
    enable = lib.mkEnableOption "Enable Heroic Games Launcher";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.lawford = {
      home.packages = [ pkgs.heroic ];
    };
  };
}
