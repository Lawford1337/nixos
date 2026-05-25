{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.programs.terminal;
in
{
  options.lawford.programs.terminal = {
    enable = lib.mkEnableOption "terminal stack (WezTerm, zsh, yazi, tmux)";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh.enable = true;

    environment.systemPackages = with pkgs; [
      btop
      ffmpegthumbnailer
      p7zip
      jq
      poppler
      fd
      ripgrep
      fzf
      imagemagick
    ];

    home-manager.users.lawford = {
      programs.fish.enable = false;

      programs.wezterm = {
        enable = true;
        extraConfig = ''
          config.hide_tab_bar_if_only_one_tab = true

          config.window_frame = {
            active_titlebar_bg = 'none',
            inactive_titlebar_bg = 'none',
          }
          
          config.colors = config.colors or {}
          config.colors.tab_bar = {
            background = 'rgba(0, 0, 0, 0)',
            active_tab = { bg_color = 'rgba(0, 0, 0, 0)', fg_color = '#ffffff' },
            inactive_tab = { bg_color = 'rgba(0, 0, 0, 0)', fg_color = '#888888' },
            new_tab = { bg_color = 'rgba(0, 0, 0, 0)', fg_color = '#888888' },
          }
        '';
      };

      programs.fastfetch = {
        enable = true;
        settings = {
          logo = {
            source = "nixos_old"; 
            padding = {
              right = 3;
            };
          };
          modules = [
            "title"
            "separator"
            "os"
            "host"
            "kernel"
            "uptime"
            "packages"
            "shell"
            "wm"
            "terminal"
            "cpu"
            "gpu"
            "memory"
            "disk"
            "battery"
            "break"
            "colors"
          ];
        };
      };


      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        shellAliases = {
          ls = "eza";
          ll = "eza -l";
          la = "eza -a";
          lla = "eza -la";
          tree = "eza --tree";
          y = "yazi";
        };
      }; 

      programs.starship = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.eza = {
        enable = true;
        enableZshIntegration = true;
        icons = "auto";
        extraOptions = [ "--group-directories-first" "--header" ];
      };

      programs.yazi = {
        enable = true;
        shellWrapperName = "y";
        enableZshIntegration = true;
      };

      programs.tmux = {
        enable = true;
        clock24 = true;
        keyMode = "vi";
      };
    };
  };
}
