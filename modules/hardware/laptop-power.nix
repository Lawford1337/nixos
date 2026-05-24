{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.hardware.laptop;
in
{
  options.lawford.hardware.laptop = {
    enable = lib.mkEnableOption "hardware optimization for Lenovo LOQ";
  };

  config = lib.mkIf cfg.enable {
    boot.kernelPackages = pkgs.linuxPackages_latest;

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    zramSwap = {
      enable = true;
      memoryPercent = 40;
    };
    
    services.auto-cpufreq.enable = false;

    services.tlp.enable = false;

    services.power-profiles-daemon.enable = true;
    
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
