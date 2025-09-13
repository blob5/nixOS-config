{ inputs, pkgs, systemSettings, ... }:
let
  hostSettings = import "${inputs.self}/hosts/${systemSettings.hostname}/settings.nix";
in
{
  # Add the theme to system packages with Qt6 variant
  environment.systemPackages = [
    (pkgs.where-is-my-sddm-theme.override {
      variants = [ "qt6" ];
    })
  ];

  # SDDM configuration
  services.displayManager = {
    sessionPackages = [ pkgs.${hostSettings.compositor} ];
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "where_is_my_sddm_theme";
      package = pkgs.kdePackages.sddm;
      extraPackages = with pkgs.kdePackages; [
        qtmultimedia
        qtsvg
        qtvirtualkeyboard
        qt5compat
      ];
      settings = {
        General = {
          GreeterEnvironment = "QT_AUTO_SCREEN_SCALE_FACTOR=1,QT_SCALE_FACTOR=auto";
        };
      };
    };
  };
}