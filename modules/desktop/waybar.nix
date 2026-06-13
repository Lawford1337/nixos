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
            margin-top = 6;
            margin-left = 12;
            margin-right = 12;
            margin-bottom = 0;
            spacing = 4;

            modules-left = [
              "hyprland/workspaces"
              "hyprland/window"
            ];
            modules-center = [ "clock" ];
            modules-right = [
              "cpu"
              "memory"
              "temperature"
              "pulseaudio"
              "network"
              "battery"
              "tray"
            ];

            "hyprland/workspaces" = {
              format = "{name}";
              on-click = "activate";
              on-scroll-up = "hyprctl dispatch workspace e+1";
              on-scroll-down = "hyprctl dispatch workspace e-1";
              active-only = false;
              all-outputs = false;
            };

            "hyprland/window" = {
              format = "{title}";
              max-length = 35;
              separate-outputs = true;
              rewrite = {
                "(.*) — Mozilla Firefox" = "󰈹 $1";
                "(.*) - fish" = "  $1";
                "(.*) - nvim" = "  $1";
                "" = "󰇄 Desktop";
              };
            };

            "clock" = {
              format = "  {:%H:%M}   {:%a, %d %b}";
              tooltip-format = "<tt><small>{calendar}</small></tt>";
              calendar = {
                mode = "month";
                on-scroll = 1;
                format = {
                  months = "<span color='#cba6f7'><b>{}</b></span>";
                  days = "<span color='#cdd6f4'>{}</span>";
                  weekdays = "<span color='#89b4fa'><b>{}</b></span>";
                  today = "<span color='#f38ba8'><b><u>{}</u></b></span>";
                };
              };
            };

            "cpu" = {
              interval = 2;
              format = "󰘚 {usage}%";
              tooltip-format = "CPU: {usage}%\nLoad: {load}";
              states = {
                warning = 70;
                critical = 90;
              };
            };

            "memory" = {
              interval = 5;
              format = "󰍛 {percentage}%";
              tooltip-format = "RAM: {used:0.1f}G / {total:0.1f}G";
              states = {
                warning = 70;
                critical = 90;
              };
            };

            "temperature" = {
              interval = 5;
              critical-threshold = 80;
              format = "{icon} {temperatureC}°C";
              format-icons = [ "" "" "" "" "" ];
            };

            "network" = {
              interval = 5;
              format-wifi = "󰤨 {essid}";
              format-ethernet = "󰈀 {ifname}";
              format-disconnected = "󰤭";
              tooltip-format-wifi = "{essid} ({signalStrength}%)\n󰕒 {bandwidthUpBytes}  󰇚 {bandwidthDownBytes}";
              tooltip-format-ethernet = "{ifname}\n󰕒 {bandwidthUpBytes}  󰇚 {bandwidthDownBytes}";
              on-click = "nm-connection-editor";
            };

            "pulseaudio" = {
              format = "{icon} {volume}%";
              format-muted = "󰝟";
              format-icons = {
                default = [ "󰕿" "󰖀" "󰕾" ];
                headphone = "󰋋";
                headset = "󰋎";
              };
              scroll-step = 5;
              on-click = "pavucontrol";
            };

            "battery" = {
              interval = 30;
              states = {
                warning = 30;
                critical = 15;
              };
              format = "{icon} {capacity}%";
              format-charging = "󰂄 {capacity}%";
              format-plugged = "󰚥 {capacity}%";
              format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
              tooltip-format = "{timeTo}";
            };

            "tray" = {
              icon-size = 16;
              spacing = 6;
              show-passive-items = true;
            };
          };
        };
        style = ''
          window#waybar {
            background-color: rgba(0, 0, 0, 0.5);
            border-radius: 12px;
          }
        '';
      };
    };
  };
}
