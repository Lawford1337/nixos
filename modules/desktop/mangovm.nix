{ config, pkgs, lib, ... }:

{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  programs.xwayland.enable = true;

  services.displayManager.sessionPackages = [
    (pkgs.writeTextFile {
      name = "mangovm-wayland-session";
      destination = "/share/wayland-sessions/mangovm.desktop";
      text = ''
        [Desktop Entry]
        Name=MangoVM
        Comment=Mango Window Manager (Wayland)
        Exec=mangovm
        Type=Application
        DesktopNames=MangoVM
      '';
    })
  ];

  environment.systemPackages = with pkgs; [
    polkit_gnome
    
  ];

  security.polkit.enable = true;
}
