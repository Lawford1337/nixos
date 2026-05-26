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
      home.packages = with pkgs; [
        nodePackages.typescript-language-server
        nodePackages.typescript
      ];

      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        
        extraPackages = with pkgs; [
          ripgrep
          fd
          curl
          wget
          biome
        ];
      };
    };
  };
}
