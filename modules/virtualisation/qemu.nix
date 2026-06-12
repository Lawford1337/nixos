{ config, pgks, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      ovmf.enable = true;
    };
  };

  programs.virt-manager.enable = true;
  progrems.dconf.enable = true;

  enviroment.systemPackages = with pkgs; [
    virt-manager
    qemu_kvm
    libvirtd
    spice
    spice-gtk
    spice-protocol
  ];
  users.users.lawford.extraGroups = [ "libvirtd" "kvm" ]
}
