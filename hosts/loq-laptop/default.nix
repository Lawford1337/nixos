{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/core.nix
  ];

  networking.hostName = "loq-laptop";

  lawford.system.core.enable = true;

  users.users.lawford = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "23.11"; 
}
