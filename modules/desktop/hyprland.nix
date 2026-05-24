{ lib, config, pkgs, inputs, ... }:

let
  cfg = config.lawford.desktop.hyprland;
in
{
  options.lawford.desktop.hyprland = {
    enable = lib.mkEnableOption "Enable hyprland with quickshell ecosystem"; 
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true; 
      xwayland.enable = true;
    };
    services.xserver.enable = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = false;
    };
    
    services.gnome.gnome-keyring.enable = true;
    services.gnome.gcr-ssh-agent.enable = lib.mkForce false;
    programs.ssh.startAgent = true;
    security.pam.services.sddm.enableGnomeKeyring = true;

    services.xserver.xkb = {
      layout = "us,ru";
      options = "grp:alt_shift_toggle";
    };
    
    console.useXkbConfig = true;

    environment.systemPackages = with pkgs; [
      qt6.qmake
      hyprshot
      wl-clipboard
      awww
      libnotify
      inputs.caelestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.caelestia-shell.inputs.caelestia-cli.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      nerd-fonts.jetbrains-mono 
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
      pulse.enable = true;
    };
  };
}
