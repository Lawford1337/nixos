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
    boot.initrd.kernelModules = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

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
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };
}
