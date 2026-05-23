{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.programs.vscodium;
in
{
  options.lawford.programs.vscodium = {
    enable = lib.mkEnableOption "Enable VScodium";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.lawford = {
      programs.vscode = {
        enable = true;
	package = pkgs.vscodium;

	extensions = with pkgs.vscode-extensions; [
	  bbenoins.nix
	  rust-lang.rust-analyzer
	  tamasfe.even-better-toml
	  dbaeumer.vscode-eslint
	  biomejs.biome
	  eamodio.gitlens
	  gruntfuggly.todo-tree
	  jeanp413.open-remote-ssh
        ];

	userSettings = {
	  "window.titlebarStyle" = "custom";
	  "telemetry.telemetryLevel" = "off";
	  "editor.fontSize" = 14;
	  "editor.formatOnSave" = true;
	  "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'Courier New', monospace";
	};
      };
    };
  };
}
