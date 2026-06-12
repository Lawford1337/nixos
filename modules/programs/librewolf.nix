{ lib, config, pkgs, ... }:
let
  cfg = config.lawford.programs.librewolf;
in
{
  options.lawford.programs.librewolf = {
    enable = lib.mkEnableOption "Librewolf for research";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.lawford = {
      programs.librewolf = {
        enable = true;
        settings = {
          "privacy.resistFingerprinting" = false;
          "webgl.disabled" = false;
          "privacy.userContext.enabled" = true;
          "privacy.userContext.ui.enabled" = true;
          "privacy.clearOnShutdown.cookies" = false;
          "privacy.clearOnShutdown.history" = false;
          "privacy.sanitize.sanitizeOnShutdown" = false;
          "network.cookie.lifetimePolicy" = 0;
        };
      };
    };
  };
}
