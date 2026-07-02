{ config, lib, pkgs, ... }:

let
  cfg = config.programs.osu-lazer;
 Kin
{
  options.programs.osu-lazer = {
    enable = lib.mkEnableOption "osu!lazer client";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      osu-lazer-bin
    ];
  };
}
