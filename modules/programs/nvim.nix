{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.programs.neovim;
in
{
  options.lawford.programs.neovim = {
    enable = lib.mkEnableOption "Enable Neovim editor";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wl-clipboard
      git
    ];

    home-manager.users.lawford = {
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        
	initLua = builtins.readFile ./init.lua;

	plugins = with pkgs.vimPlugins; [
          mini-nvim
        ];

        extraPackages = with pkgs; [
          ripgrep
          fd
          curl
          wget
          biome
          vtsls
          typescript
          nodejs
	  lazygit
        ];
      };
    };
  };
}
