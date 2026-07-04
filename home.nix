{ config, pkgs, ... }:

{
  home.username = "morgan";
  home.homeDirectory = "/home/morgan";
  programs.git.enable = true;
  home.stateVersion = "26.05";


  programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
      	btw = "echo i use nixos-btw";
      	nrs = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
	      ld = "lazydocker";
	      ls = "eza --icons -1";
	      c = "clear";
      	z = "zoxide";
    	};
    };
  
  home.packages = with pkgs; [
    neovim
    zoxide
    ripgrep
    nil
    nixpkgs-fmt
    python3
    gcc
    lazydocker
    lazygit
  ];
  
  programs.zoxide = {
	
	enableZshIntegration = true;
  };
}
