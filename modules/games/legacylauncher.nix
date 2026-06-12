{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.games.legacylauncher;

  bootstrap = pkgs.fetchurl {
    url = "https://llaun.ch/jar";
    hash = "sha256-Cbp1F8ipsweA/5pt4jC4kFJHg1rg2pFNZpkeKztLbE4=";
  };

  legacylauncher = pkgs.symlinkJoin {
    name = "legacylauncher";
    paths = [
      (pkgs.writeShellScriptBin "legacylauncher" ''
        export JAVA_HOME="${pkgs.jdk17}"
        export PATH="${pkgs.jdk17}/bin:$PATH"
        export _JAVA_OPTIONS="-Djava.net.useSystemProxies=true"
        exec ${pkgs.jdk17}/bin/java -jar ${bootstrap} "$@"
      '')
      (pkgs.makeDesktopItem {
        name = "legacylauncher";
        desktopName = "Legacy Launcher";
        exec = "legacylauncher";
        icon = "legacylauncher";
        categories = [ "Game" ];
      })
    ];
  };
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
