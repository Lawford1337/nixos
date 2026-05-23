{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.virtualisation.docker;
int
{
  options.lawford.virtualisation.docker = {
    enable = lib.mkenableOption "Enable Docker and docker-compose";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      autoPrune.enable = true;

      rootless = {
        enable = true;
	setSocketVariable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      docker-compose
    ];
  };
}
