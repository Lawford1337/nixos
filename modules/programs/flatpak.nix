{ config, lib, pkgs, ... }:

let
  cfg = config.modules.flatpak;
in
{
  options.modules.flatpak = {
    enable = lib.mkEnableOption "Flatpak ecosystem and Flatseal";
    
    userName = lib.mkOption {
      type = lib.types.str;
      default = "lawford";
      description = "Имя пользователя, которому установится Flatseal";
    };
  };

  config = lib.mkIf cfg.enable {
    
    services.flatpak.enable = true;

    users.users.${cfg.userName}.packages = with pkgs; [
      flatseal
    ];
    
  };
}
