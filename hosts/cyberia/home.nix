{ config, pkgs, ... }:

{
  imports = [
    # Services
    ../../modules/services/home/swaync.nix


    # Programs 
    ../../modules/programs/editors/vscode.nix
    ../../modules/programs/terminals/wezterm/wezterm.nix
    ../../modules/programs/terminals/kitty/kitty.nix
    ../../modules/programs/terminals/zsh/zsh.nix
    ../../modules/programs/spicetify/spicetify.nix
    ../../modules/programs/nixcord.nix
    ../../modules/programs/git.nix
    ../../modules/programs/viu/viu.nix


    # Desktop
    ../../modules/desktop/compositors/niri/niri.nix
    ../../modules/desktop/waybar/waybar.nix
    ../../modules/desktop/rofi/rofi.nix
    ../../modules/desktop/stylix/stylix.nix
    ../../modules/desktop/fonts.nix


    # Packages
    ../../modules/packages/home/applications.nix
    ../../modules/packages/home/archive-tools.nix
    ../../modules/packages/home/CLI-tools.nix
    ../../modules/packages/home/cursor.nix
    ../../modules/packages/home/development.nix
    ../../modules/packages/home/entertainment.nix
    ../../modules/packages/home/fun.nix
    ../../modules/packages/home/home-manager.nix
    ../../modules/packages/home/pentesting.nix
    ../../modules/packages/home/terminals.nix

  ];


  niri = {
    monitors = [ "eDP-1,1920x1080@60,0x0,1" ];
    input.sensitivity = 0.5;
    input.kb_layout = "us";
  };

  # Host-specific home-manager settings
  home.username = "blob";
  home.homeDirectory = "/home/blob";
  home.stateVersion = "25.05"; # Match your NixOS version
  
  nixpkgs.config.allowUnfree = true;

}
