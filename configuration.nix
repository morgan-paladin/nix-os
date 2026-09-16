
{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    (builtins.fetchTarball {
      url = "https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz";
    } + "/nixos")
  ];

  # Use the grub EFI boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";

  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.morgan = {
     isNormalUser = true;
     extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
     shell = pkgs.zsh;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;   
  home-manager.users.morgan = import ./home.nix;
  home-manager.backupFileExtension = "backup";

  # Enable docker
  virtualisation.docker.enable = true;

  # VM Virtualisation
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
     wget
     curl
     micro
     fastfetch
     btop
     fd
     fzf
     eza
     jq
     hyprland
     virt-manager
     unzip
     noctalia
   ];

  programs.hyprland = { # or wayland.windowManager.hyprland
    enable = true;
    xwayland.enable = true;
  }; 

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-mono
  ];   

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;


  # Greetd
  services.greetd = {
  enable = true;
  settings = {
    default_session = {
      # Specify the greeter and the session command (e.g., sway, hyprland)
      command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd start-hyprland";
      user = "greeter";
    };
  };
  };   


  nix.settings.experimental-features = [ "nix-command" ];
  system.stateVersion = "26.05";
}

