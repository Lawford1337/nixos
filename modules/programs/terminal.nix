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
      fastfetch
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

      programs.wezterm.enable = true;

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
