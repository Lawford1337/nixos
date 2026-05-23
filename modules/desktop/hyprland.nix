{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.desktop.hyprland;
in
{
  options.lawford.desktop.hyprland = {
    enable = lib.mkEnableOption "Enable hyprland with quickshell ecosystem"; 
  };

  config = mkif cfg.enable {
    programs.hyprland = {
      enable = true; 
      xwayland.enable = true;
    };

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    
    services.xserver.xkb = {
      layout = "us,ru";
      options = "grp:alt_shift_toogle";
    };
    
    console.useXkbConfig = true;

    environment.systemPackages = with pkgs; [
      qt6.qtwayland
      qt6.qmake

      wl-clipboard
      swww
      libnotify
    ];

    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      (nerdfonts.override {
        fonts = [ "JetBrainsMono" "MaterialDesignIcons" ];
      })
    ];

    xdg.portal = {
      enable = true;
      extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      puls.enable = true;
    };
  };
}
