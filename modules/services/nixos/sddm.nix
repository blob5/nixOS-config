{ inputs, pkgs, systemSettings, ... }:
let
  hostSettings = import "${inputs.self}/hosts/${systemSettings.hostname}/settings.nix";
in
{
  # Add the theme to system packages with Qt6 variant
  environment.systemPackages = [
    (pkgs.sddm-astronaut.override {
      embeddedTheme = "hyprland_kath";
    })
  ];

  # SDDM configuration
  services.displayManager = {
    sessionPackages = [ pkgs.${hostSettings.compositor} ];
    sddm = {
      enable = true;
      wayland.enable = false;
      theme = "sddm-astronaut-theme";
      package = pkgs.kdePackages.sddm;
      extraPackages = with pkgs.kdePackages; [
        qtmultimedia
        qtsvg
        qtvirtualkeyboard
        qt5compat
      ];
    };
  };
}