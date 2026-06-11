{ config, pkgs, lib, ... }:

{
  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  services.displayManager.sessionPackages = [
    (pkgs.writeTextFile {
      name = "mangovm-session";
      destination = "/share/wayland-sessions/mangovm.desktop";
      text = ''
        [Desktop Entry]
        Name=MangoVM
        Comment=My Custom Mango Window Manager
        Exec=mangovm
        Type=Application
      '';
    })
  ];

  environment.systemPackages = with pkgs; [
    kitty
    polkit_gnome
  ];

  security.polkit.enable = true;
}
