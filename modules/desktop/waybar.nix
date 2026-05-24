{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.desktop.waybar;
in
{
  options.lawford.desktop.waybar = {
    enable = lib.mkEnableOption "Enable Waybar status bar";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.lawford = {
      programs.waybar = {
        enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            height = 36;
            margin-top = 0;
            margin-bottom = 0;
            
            modules-left = [ "hyprland/workspaces" "hyprland/window" ];
            modules-center = [ "clock" ];
            modules-right = [ "tray" "cpu" "memory" "network" "pulseaudio" "battery" ];

            "hyprland/workspaces" = {
              format = "{icon}";
              on-click = "activate";
            };

            "clock" = {
              format = "{:%H:%M | %d.%m}";
              tooltip-format = "<tt>{calendar}</tt>";
            };

            "cpu" = {
              format = "  {usage}%";
            };

            "memory" = {
              format = "  {}%";
            };

            "network" = {
              format-wifi = "  {essid}";
              format-ethernet = "󰈀  connected";
              format-disconnected = "⚠ Offline";
              on-click = "nm-connection-editor";
            };

            "pulseaudio" = {
              format = "{icon} {volume}%";
              format-muted = "󰝟";
              format-icons = {
                default = [ "" "" "" ];
              };
              on-click = "pavucontrol";
            };

            "battery" = {
              states = {
                warning = 30;
                critical = 15;
              };
              format = "{icon} {capacity}%";
              format-icons = [ "" "" "" "" "" ];
            };
          };
        };
      };
    };
  };
}
