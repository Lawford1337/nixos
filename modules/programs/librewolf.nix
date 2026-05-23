{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.programs.librewolf;
in
{
  options.lawford.programs.librewolf = {
    enable = lib.mkEnableOption "Librewolf with containers";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      librewolf
    ];

    home-manager.users.lawford = {
      programs.librewolf = {
        enable = true;
	settings = {
	  "privacy.userContext.enabled" = true;
	  "privacy.userContext.ui.enabled" = true;
	  "privacy.cleanOnShutdown.cookies" = false;
	};
      };
    };
  };
}
