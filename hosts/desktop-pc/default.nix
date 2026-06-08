{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    
    ../../modules/hardware/desktop-nvidia.nix
    
    ../../modules/system/core.nix
    ../../modules/system/netbird.nix
    
    # ../../modules/desktop/hyprland.nix
    # ../../modules/desktop/mangowm.nix 
    
    ../../modules/programs/nvim.nix
    ../../modules/programs/terminal.nix
    ../../modules/programs/librewolf.nix
    ../../modules/programs/ssh.nix
    ../../modules/virtualisation/docker.nix
  ];

  networking.hostName = "desktop-pc";

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
}
