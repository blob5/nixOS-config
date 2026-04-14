{ pkgs, hostSettings, ... }:

{
  # Add the theme to system packages with Qt6 variant
  environment.systemPackages = [
    (pkgs.sddm-astronaut.override {
      embeddedTheme = "hyprland_kath";
    })
  ];

  # SDDM configuration
  services.displayManager = {
    sessionPackages =
      if hostSettings.compositor != "" then [ pkgs.${hostSettings.compositor} ] else [ ];
    sddm = {
      enable = true;
      wayland = {
        enable = true;
        compositor = "kwin";
      };
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
