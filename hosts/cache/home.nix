{ config, pkgs, ... }:

{
  imports = [
    # Services
    ../../modules/services/home/mako/mako.nix

    # Programs 
    ../../modules/programs/editors/vscode.nix
    ../../modules/programs/terminals/zsh/zsh.nix
    ../../modules/programs/git.nix

    # Desktop
    ../../modules/desktop/compositors/hyprland/hyprland.nix
    ../../modules/desktop/stylix/stylix.nix
    ../../modules/desktop/fonts.nix
    ../../modules/desktop/rofi/rofi.nix


    # Packages
    ../../modules/packages/home/archive-tools.nix
    ../../modules/packages/home/CLI-tools.nix
    ../../modules/packages/home/cursor.nix
    ../../modules/packages/home/fun.nix
    ../../modules/packages/home/home-manager.nix
    ../../modules/packages/home/terminals.nix

  ];

  home = {
    packages = with pkgs; [
      # Quickshell Nocaalia configuration
      inputs.noctalia.packages.${system}.default

      # Media & Applications
      nautilus # File manager
      kdePackages.ark # Archive manager
      kdePackages.gwenview # Image viewer
      vlc
      obsidian
    ];
  };

  hyprland = {
    monitors = [ "DP-1, 1920x1080@60, 0x0, 1" ];
    input.sensitivity = -0.75;
    input.kb_layout = "us";
    accel_profile = "flat";
  };

  # Host-specific home-manager settings
  home.username = "blob";
  home.homeDirectory = "/home/blob";
  home.stateVersion = "25.11"; # Match your NixOS version
  

}
