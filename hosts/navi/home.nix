{
  config,
  pkgs,
  userSettings,
  ...
}:

{
  imports = [
    ../common/home/desktop.nix

    # Services
    ../../modules/services/home/easyeffects.nix
    ../../modules/services/home/udiskie.nix

    # Desktop
    ../../modules/desktop/compositors/hyprland/hyprland.nix

  ];

  hyprland = {
    monitors = [
      "DP-1,2560x1440@240,0x0,1"
      "DP-3,2560x1440@120,2560x-600,1,transform,3"
    ];
    input.sensitivity = -0.75;
    input.kb_layout = "us";
    accel_profile = "flat";
  };

  # Host-specific home-manager settings
  home.username = userSettings.username;
  home.homeDirectory = userSettings.homeDirectory;
  home.stateVersion = "26.05";

}
