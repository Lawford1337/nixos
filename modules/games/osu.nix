{ config, lib, pkgs, ... }:

let
  cfg = config.programs.osu-lazer;
in
{
  options.programs.osu-lazer = {
    enable = lib.mkEnableOption "osu!lazer client";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      osu-lazer-bin
    ];
  };
}
