{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.services.netbird;
in
{
  options.lawford.services.netbird = {
    enable = lib.mkEnableOption "Enable netbird"
  };

  config = lib.mkIf cfg.enable {
    services.netbird.enable = true;
    environment.systemPackages = with pkgs; [
      netbird
    ];
    networking.firewall = {
      checkReversePath = "loose";
    };
  };
}
