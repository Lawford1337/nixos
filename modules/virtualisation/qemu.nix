{ config, pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
    };
  };

  programs.virt-manager.enable = true;
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    virt-manager
    qemu_kvm
    libvirt
    spice
    spice-gtk
    spice-protocol
  ];
  users.users.lawford.extraGroups = [ "libvirtd" "kvm" ];
}
