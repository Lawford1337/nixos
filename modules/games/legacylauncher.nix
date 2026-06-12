{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.games.legacylauncher;

  bootstrap = pkgs.fetchurl {
    url = "https://llaun.ch/jar";
    hash = "";
  };

  legacylauncher = pkgs.writeShellScriptBin "legacylauncher" ''
    exec ${pkgs.jdk17}/bin/java -jar ${bootstrap} "$@"
  '';
in
{
  options.lawford.games.legacylauncher = {
    enable = lib.mkEnableOption "Enable Legacy Launcher";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.lawford = {
      home.packages = [ legacylauncher ];
    };
  };
}
