{ lib, config, pkgs, ... }:

let
  cfg = config.lawford.programs.ssh;
in
{
  options.lawford.programs.ssh = {
    enable = lib.mkEnableOption "Enable SSH client and authentication agent";
  };

  config = lib.mkIf cfg.enable {
  programs.ssh.startAgent = true;    
  home-manager.users.lawford = {
    programs.ssh = {
      enable = true;
      extraConfig = ''
        ServerAliveInterval 60
	ServerAliveCountMax 3
	AddKeysToAgent yes
      '';
        matchBlocks = {
          "vmdev" = {
            hostname = "94.131.95.186";
	    user = "lawford";
	    forwardAgent = true;
	  };
	  "forge" = {
            user = "git";
	    identityFile = "~/.ssh/id_ed25519";
	  };
	};
      };
    };  
  };
}
