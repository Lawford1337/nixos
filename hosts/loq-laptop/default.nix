{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/core.nix
    ../../modules/hardware/laptop-power.nix
    ../../modules/programs/terminal.nix
    ../../modules/desktop/hyprland.nix
    ../../modules/programs/ssh.nix
    ../../modules/system/netbird.nix
    ../../modules/programs/vscodium.nix
    ../../modules/programs/librewolf.nix
    ../../modules/virtualisation/docker.nix
    ../../modules/desktop/hyprshot.nix
  ];

  networking.hostName = "ll-laptop";

  lawford.system.core.enable = true;
  lawford.desktop.hyprshot.enable = true;
  lawford.hardware.laptop.enable = true;
  lawford.desktop.hyprland.enable = true;
  lawford.programs.terminal.enable = true;
  lawford.programs.ssh.enable = true;
  lawford.services.netbird.enable = true;
  lawford.virtualisation.docker.enable = true;
  lawford.programs.vscodium.enable = true;
  lawford.programs.librewolf.enable = true;


  users.users.lawford = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "docker" ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.11"; 
}
