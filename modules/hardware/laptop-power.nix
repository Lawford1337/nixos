{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.hardware.laptop;
in
{
 options.lawford.hardware.laptop = {
  enable = lib.mkEnableOption "hardware optimization for Lenovo LOQ";
  };

  config = lib.mkIf cfg.enable {
    boot.kernelPackages = pkgs.linuxPackages_zen;


    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    zramSwap = {
      enable = true;
      memoryPercent = 40;
    };
    
    services.auto-cpufreq.enable = true;

    services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };

    services.power-profiles-daemon.enable = false;
    
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = false;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
   };
}

