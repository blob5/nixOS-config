{ config, inputs, pkgs, userSettings, ... }:

{
  imports = [
    # Programs 
    ../../modules/programs/editors/vscode.nix
    ../../modules/programs/terminals/zsh/zsh.nix
    ../../modules/programs/git.nix
    ../../modules/programs/terminals/wezterm/wezterm.nix


    # Desktop
    ../../modules/desktop/theme.nix
    ../../modules/desktop/fonts.nix
    ../../modules/desktop/rofi/rofi.nix
    ../../modules/desktop/compositors/niri/niri.nix
    ../../modules/desktop/desktop-entries.nix



    # Packages
    ../../modules/packages/home/archive-tools.nix
    ../../modules/packages/home/CLI-tools.nix
    ../../modules/packages/home/cursor.nix
    ../../modules/packages/home/fun.nix
    ../../modules/packages/home/home-manager.nix

  ];

  home = {
    packages = with pkgs; [
      # Quickshell Noctalia configuration
      inputs.noctalia.packages.${system}.default

      # Media & Applications
      nautilus # File manager
      kdePackages.ark # Archive manager
      kdePackages.gwenview # Image viewer
      vlc
      obsidian
    ];
  };


  niri = {
    monitors = [ "eDP-1,1920x1080@60,0x0,1" ];
    input.sensitivity = 0.5;
    input.kb_layout = "us";
  };

  # Host-specific home-manager settings
  home.username = userSettings.username;
  home.homeDirectory = userSettings.homeDirectory;
  home.stateVersion = "25.11"; # Match your NixOS version
}
