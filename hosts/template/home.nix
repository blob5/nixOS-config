{ config, pkgs, userSettings, ... }:

{
  imports = [
    # Programs
    # ../../modules/programs/terminals/zsh/zsh.nix
    # ../../modules/programs/git.nix

    # Desktop
    # ../../modules/desktop/fonts.nix
    # ../../modules/desktop/stylix/stylix.nix

    # Packages
    # ../../modules/packages/home/CLI-tools.nix
    # ../../modules/packages/home/home-manager.nix
  ];

  # Host-specific home-manager settings
  home.username = userSettings.username;
  home.homeDirectory = userSettings.homeDirectory;
  home.stateVersion = "25.11";
}
