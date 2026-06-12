{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.games.hmcl;
in
{
  options.lawford.games.hmcl = {
    enable = lib.mkEnableOption "Enable HMCL launcher";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.lawford = {
      home.packages = [ pkgs.hmcl ];
      
      home.sessionVariables = {
        _JAVA_AWT_WM_NONREPARENTING = "1";
      };
    };
  };
}
