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
      firefox
    ];

    home-manager.users.lawford = {
    programs.librewolf = {
      enable = true;
      settings = {
          "privacy.clearOnShutdown.cookies" = false;
          "privacy.clearOnShutdown.history" = false;
          "privacy.clearOnShutdown.offlineApps" = false;
          "privacy.resistFingerprinting" = false;
          "network.cookie.lifetimePolicy" = 0;
          "privacy.userContext.enabled" = true;
          "privacy.userContext.ui.enabled" = true;
          "webgl.disabled" = false;
          
          "privacy.sanitize.sanitizeOnShutdown" = false;
          
          "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
          "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = false;
          "privacy.clearOnShutdown_v2.siteSettings" = false;
        };
      };
    };
  };
}
