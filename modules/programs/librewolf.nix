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
          "privacy.clearOnShutdown.cookies" = false;
          "privacy.clearOnShutdown.history" = false;
          "privacy.clearOnShutdown.offlineApps" = false;
          "network.cookie.lifetimePolicy" = 0;
          "privacy.userContext.enabled" = true;
          "privacy.userContext.ui.enabled" = true;
        };
      };
    };
  };
}
