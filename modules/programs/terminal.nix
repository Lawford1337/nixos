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
      unzip
    ];

    home-manager.users.lawford = {
      programs.fish.enable = false;

      programs.spotify-player = {
        enable = true;
        settings = {
          # theme = "dracula";
          client_id = "d420a117a32841c2b3474932e49fb54b";
          client_port = 8080;
          login_redirect_uri = "http://127.0.0.1:8080/login";
          playback_format = ''
            {status} {track} • {artists} {liked}
            {album} • {genres}
            {metadata}'';
          playback_metadata_fields = [
            "repeat"
            "shuffle"
            "volume"
            "device"
          ];
          notify_timeout_in_secs = 0;
          notify_transient = false;
          tracks_playback_limit = 50;
          app_refresh_duration_in_ms = 32;
          playback_refresh_duration_in_ms = 0;
          page_size_in_rows = 20;
          play_icon = "▶";
          pause_icon = "▌▌";
          liked_icon = "♥";
          explicit_icon = "(e)";
          border_type = "Rounded";
          progress_bar_type = "Rectangle";
          progress_bar_position = "Bottom";
          genre_num = 2;
          cover_img_length = 9;
          cover_img_width = 5;
          cover_img_scale = 1.0;
          enable_media_control = true;
          enable_streaming = "Always";
          enable_audio_visualization = false;
          enable_notify = false;
          enable_cover_image_cache = true;
          default_device = "spotify-player";
          notify_streaming_only = false;
          seek_duration_secs = 5;
          sort_artist_albums_by_type = false;
          volume_scroll_step = 5;
          enable_mouse_scroll_volume = true;

          notify_format = {
            summary = "{track} • {artists}";
            body = "{album}";
          };

          layout = {
            playback_window_position = "Top";
            playback_window_height = 6;
            library = {
              playlist_percent = 40;
              album_percent = 40;
            };
          };

          device = {
            name = "spotify-player";
            device_type = "speaker";
            volume = 70;
            bitrate = 320;
            audio_cache = false;
            normalization = false;
            autoplay = false;
          };
        };
      };

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
            source = "nixos"; 
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
