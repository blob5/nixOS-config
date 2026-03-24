{ config, pkgs, userSettings, ... }:

{
  imports = [

    # Services
    ../../modules/services/home/easyeffects.nix
    ../../modules/services/home/udiskie.nix


    # Programs
    ../../modules/programs/editors/vscode.nix
    ../../modules/programs/editors/vim.nix
    ../../modules/programs/terminals/kitty/kitty.nix
    ../../modules/programs/terminals/zsh/zsh.nix
    ../../modules/programs/spicetify/spicetify.nix
    ../../modules/programs/nixcord.nix
    ../../modules/programs/git.nix
    ../../modules/programs/viu/viu.nix
    ../../modules/programs/anime4k/anime4k.nix

    # Desktop
    ../../modules/desktop/compositors/hyprland/hyprland.nix
    ../../modules/desktop/fonts.nix
    ../../modules/desktop/theme.nix
    ../../modules/desktop/rofi/rofi.nix
    ../../modules/desktop/desktop-entries.nix

    # Packages
    ../../modules/packages/home/applications.nix
    ../../modules/packages/home/archive-tools.nix
    ../../modules/packages/home/CLI-tools.nix
    ../../modules/packages/home/cursor.nix
    ../../modules/packages/home/development.nix
    ../../modules/packages/home/entertainment.nix
    ../../modules/packages/home/fun.nix
    ../../modules/packages/home/home-manager.nix

  ];

  hyprland = {
    monitors = [ "DP-1,2560x1440@240,0x0,1" "DP-3,2560x1440@120,2560x-600,1,transform,3" ];
    input.sensitivity = -0.75;
    input.kb_layout = "us";
    accel_profile = "flat";
  };

  # Host-specific home-manager settings
  home.username = userSettings.username;
  home.homeDirectory = userSettings.homeDirectory;
  home.stateVersion = "26.05";

}
