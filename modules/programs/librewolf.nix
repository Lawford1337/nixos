{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.programs.librewolf;
in
{
  optins.lawford.programs.librewolf = {
    enable = lib.mkEnableOption "Librewolf with containers";
  };

  config = lib.mkif cfg.enable {
    enviroment.systemPackages = with pkgs; [
      librewolf
    ];

    home-manager.users.lawford = {
      programs.librewolf = {
        enable = true;
	setting = {
	  "privacy.userContext.enabled" = true;
	  "privacy.userContext.ui.enabled" = true;
	  "privacy.cleanOnShutdown.cookies" = false;
	};
      };
    };
  };
}
