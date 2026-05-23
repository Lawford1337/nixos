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
      programs.vscodium = {
        enable = true;
	package = pkgs.vscodium;
        profiles.default = {
	extensions = with pkgs.vscode-extensions; [
	  bbenoist.nix
	  rust-lang.rust-analyzer
	  tamasfe.even-better-toml
	  dbaeumer.vscode-eslint
	  biomejs.biome
	  eamodio.gitlens
	  gruntfuggly.todo-tree
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
  };
}
