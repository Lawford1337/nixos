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
      wezterm
      fastfetch
      btop
      fzf
      ripgrep
    ];

    home-manager.users.lawford = {
      programs.zsh = {
        enable = true;
	enableCompletion = true;
	autosuggestion.enable = true;
	syntaxHighlighting.enable = true;

	oh-my-zsh = {
          enable = true;
	  plugins = [ "git" "sudo" "z" ];
	  theme = "Powerlevel10k";
	};
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
