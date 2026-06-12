{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.games.prismlauncher;
  
  prismlauncher-9_1 = pkgs.prismlauncher.overrideAttrs (old: rec {
    version = "9.1";
    src = pkgs.fetchFromGitHub {
      owner = "PrismLauncher";
      repo = "PrismLauncher";
      rev = version;
      hash = "sha256-Vy3TnmQhYfqbLCM4sgUHFdj6xD8N8BQBhzTD/pjNInk=";
      fetchSubmodules = true;
    };
  });
in
{
  options.lawford.games.prismlauncher = {
    enable = lib.mkEnableOption "Enable Prism Launcher 9.1";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.lawford = {
      home.packages = [ prismlauncher-9_1 ];
    };
  };
}
