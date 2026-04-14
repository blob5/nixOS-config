{
  config,
  pkgs,
  userSettings,
  ...
}:

{
  imports = [
    ../common/home/desktop.nix

    ../../modules/services/home/udiskie.nix

    # Desktop
    ../../modules/desktop/compositors/niri/niri.nix

    # Packages
    ../../modules/packages/home/pentesting.nix

  ];

  niri = {
    monitors = [ "eDP-1,1920x1080@60,0x0,1" ];
    input.sensitivity = 0.5;
    input.kb_layout = "us";
  };

  # Host-specific home-manager settings
  home.username = userSettings.username;
  home.homeDirectory = userSettings.homeDirectory;
  home.stateVersion = "26.05"; # Match your NixOS version

}
