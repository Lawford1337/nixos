{ config, pkgs, ... }:

{
  home.username = "lawford";
  home.homeDirectory = "/home/lawford";

  home.stateVersion = "23.11"; 

  programs.home-manager.enable = true;
}
