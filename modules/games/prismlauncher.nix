{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.games.prismlauncher;
in
{
  options.lawford.games.prismlauncher = {
    enable = lib.mkEnableOption "Enable Prism Launcher";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.lawford = {
      home.packages = [ pkgs.prismlauncher ];
    };
  };
}
