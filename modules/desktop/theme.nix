{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.desktop.theme;
in
{
  options.lawford.desktop.theme = {
    enable = lib.mkEnableOption "Enable global Stylix theming";
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      image = ../../assets/walll.jpg;
      polarity = "dark";

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
        sansSerif = {
          package = pkgs.noto-fonts;
          name = "Noto Sans";
        };
        serif = {
          package = pkgs.noto-fonts;
          name = "Noto Serif";
        };
        sizes = {
          applications = 11;
          terminal = 12;
          desktop = 10;
          popups = 10;
        };
      };

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
      };
      opacity = {
        terminal = 0.85; 
        desktop = 1.0;
        applications = 1.0;
      };
    };
  };
}
