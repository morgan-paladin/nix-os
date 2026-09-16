{ config, pkgs, ... }:

{
  home.username = "morgan";
  home.homeDirectory = "/home/morgan";
  home.stateVersion = "26.05";

  programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
      lg = "lazygit";
      nrs = "sudo nixos-rebuild switch";
	    ld = "lazydocker";
	    ls = "eza --icons -1";
	    c = "clear";
    	};
    };
 
  programs.git = {
  	enable = true;

  	settings = {
    	user = {
      	name = "morgan-paladin";
      	email = "morgan.paladin@proton.me";
    	};

    init.defaultBranch = "main";
    pull.rebase = false;
    push.autoSetupRemote = true;

  		};
	}; 
  home.packages = with pkgs; [
    ripgrep
    nil
    nixpkgs-fmt
    python3
    gcc
    git
    lazydocker
    lazygit
    vscodium
    waybar
    kitty
  ];

  programs.brave.enable = true;
  
  programs.zoxide = {
  	enable = true;
	  enableZshIntegration = true;
  };
  programs.starship = {
  	enable = true;
  	enableZshIntegration = true;
  	settings = {
  		command_timeout = 1300;
  		scan_timeout = 50;
  	};
  };

  programs.neovim = {
  enable = true;
};

}
