{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.system.core;
in
{
  options.lawford.system.core = {
    enable = lib.mkEnableOption "Enable core system configuration";
  };

  config = lib.mkIf cfg.enable {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings.auto-optimise-store = true;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;

    time.timeZone = "Asia/Almaty";
    i18n.defaultLocale = "en_US.UTF-8";

    environment.systemPackages = with pkgs; [
      git
      wget
      curl
      neovim
    ];
  };
}
