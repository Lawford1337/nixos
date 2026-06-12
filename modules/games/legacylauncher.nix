{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.games.legacylauncher;

  bootstrap = pkgs.fetchurl {
    url = "https://llaun.ch/jar";
    hash = "sha256-Cbp1F8ipsweA/5pt4jC4kFJHg1rg2pFNZpkeKztLbE4=";
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
