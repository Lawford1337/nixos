{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    
    ../../modules/hardware/desktop-nvidia.nix
    
    ../../modules/system/core.nix
    ../../modules/system/netbird.nix
    
    ../../modules/desktop/hyprland.nix
    #../../modules/desktop/mangowm.nix 
    ../../modules/desktop/hyprshot.nix
    ../../modules/desktop/waybar.nix
    ../../modules/desktop/theme.nix
    ../../modules/desktop/launcher.nix

    ../../modules/programs/nvim.nix
    ../../modules/programs/terminal.nix
    ../../modules/programs/librewolf.nix
    ../../modules/programs/ssh.nix
    ../../modules/virtualisation/docker.nix
  ];

  networking.hostName = "desktop-pc";

#  boot.loader.grub = {
#    enable = true;
#    efiSupport = true;
#    device = "nodev";
#    useOSProber = true;
#  };
#  boot.loader.efi.canTouchEfiVariables = true;
  
  lawford.system.core.enable = true;
  lawford.desktop.hyprshot.enable = true;
  lawford.desktop.hyprland.enable = true;
  lawford.desktop.waybar.enable = true;
  lawford.desktop.theme.enable = true;
  lawford.desktop.launcher.enable = true;
  
  lawford.programs.terminal.enable = true;
  lawford.programs.neovim.enable = true;
  lawford.programs.librewolf.enable = true;
  lawford.programs.ssh.enable = true;

  lawford.services.netbird.enable = true;
  lawford.virtualisation.docker.enable = true;

  users.users.lawford = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "docker" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    mumble
  ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.11";
  home-manager.users.lawford.home.stateVersion = "23.11";
}
