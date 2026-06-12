{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.games.prismlauncher;

  libnbtplusplus = pkgs.fetchFromGitHub {
    owner = "PrismLauncher";
    repo = "libnbtplusplus";
    rev = "23b955121b8217c1c348a9ed2483167a6f3ff4ad";
    hash = "sha256-yy0q+bky80LtK1GWzz7qpM+aAGrOqLuewbid8WT1ilk=";
  };

  prismlauncher-unwrapped-9_1 = pkgs.prismlauncher-unwrapped.overrideAttrs (old: {
    version = "9.1";
    src = pkgs.fetchFromGitHub {
      owner = "PrismLauncher";
      repo = "PrismLauncher";
      rev = "9.1";
      hash = "sha256-WbolqvqudZq520p6pF86mFDMorpaY6E6oKCnd9f33us=";
    };
    postUnpack = ''
      rm -rf source/libraries/libnbtplusplus
      ln -s ${libnbtplusplus} source/libraries/libnbtplusplus
    '';
  });

  prismlauncher-9_1 = pkgs.prismlauncher.override {
    prismlauncher-unwrapped = prismlauncher-unwrapped-9_1;
  };
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
