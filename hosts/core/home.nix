{
  config,
  pkgs,
  userSettings,
  ...
}:

{
  imports = [
    ../common/home/base.nix

    # system
    ../../modules/desktop/fonts.nix

    # Packages
    ../../modules/packages/home/development.nix

  ];

  home = {
    packages = with pkgs; [
      hyperion-ng
      steamcmd
    ];
  };

  # Host-specific home-manager settings
  home.username = userSettings.username;
  home.homeDirectory = userSettings.homeDirectory;
  home.stateVersion = "25.11"; # Match your NixOS version

}
