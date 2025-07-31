{ config, pkgs, ... }:

{
  imports = [

    # Services
    ../../modules/services/home/easyeffects.nix

    # Programs
    ../../modules/programs/editors/vscode.nix
    ../../modules/programs/terminals/wezterm/wezterm.nix
    ../../modules/programs/terminals/kitty/kitty.nix
    ../../modules/programs/terminals/zsh/zsh.nix
    ../../modules/programs/spicetify/spicetify.nix
    ../../modules/programs/nixcord.nix
    ../../modules/programs/git.nix
    ../../modules/programs/fastanime/fastanime.nix

    # Desktop
    ../../modules/desktop/compositors/hyprland/hyprland.nix
    ../../modules/desktop/waybar/waybar.nix
    ../../modules/desktop/rofi/rofi.nix
    ../../modules/desktop/fonts.nix
    ../../modules/desktop/stylix/stylix.nix

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

  hyprland = {
    monitors = [ "DP-1,2560x1440@165,0x0,1" "HDMI-A-2,1920x1080@75,2560x-130,1,transform,3" ];
    input.sensitivity = -0.75;
    input.kb_layout = "us";
    accel_profile = "flat";
  };

  # Host-specific home-manager settings
  home.username = "blob";
  home.homeDirectory = "/home/blob";
  home.stateVersion = "25.05";

  nixpkgs.config.allowUnfree = true;

}
