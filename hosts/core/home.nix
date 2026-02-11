{ config, pkgs, userSettings, ... }:

{
  imports = [
    # Services

    # Programs 
    ../../modules/programs/terminals/zsh/zsh.nix
    ../../modules/programs/git.nix


    # Desktop
    ../../modules/desktop/fonts.nix


    # Packages
    ../../modules/packages/home/archive-tools.nix
    ../../modules/packages/home/CLI-tools.nix
    ../../modules/packages/home/development.nix
    ../../modules/packages/home/home-manager.nix
    ../../modules/packages/home/terminals.nix

  ];


  home = {
    packages = with pkgs; [
      hyperion-ng
    ];
  };


  # Host-specific home-manager settings
  home.username = userSettings.username;
  home.homeDirectory = userSettings.homeDirectory;
  home.stateVersion = "25.11"; # Match your NixOS version
  

}
