{ config, pkgs, lib, ... }:

{
  stylix.enable = true;

  stylix.autoEnable = false;

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";

  stylix.polarity = "dark";
  gtk.gtk4.theme = null;
  stylix.targets = {
    gtk.enable = true;
    kde.enable = true;
    qt = {
      enable = true;
      platform = "qtct";
    };
    vesktop.enable = true;
  };

  # Fix for theming in some KDE apps
  xdg.configFile.kdeglobals.source =
    let
      themePackage = builtins.head (
        builtins.filter (
          p: builtins.match ".*stylix-kde-theme.*" (builtins.baseNameOf p) != null
        ) config.home.packages
      );
      colorSchemeSlug = lib.concatStrings (
        lib.filter lib.isString (builtins.split "[^a-zA-Z]" config.lib.stylix.colors.scheme)
      );
    in
    "${themePackage}/share/color-schemes/${colorSchemeSlug}.colors";


  stylix.targets.gtk.extraCss = ''
    button {
      color: @theme_fg_color;
      background-color: #${config.lib.stylix.colors.base02};
      border: 0.1em solid @borders;
    }
  '';

  stylix.icons ={
    enable = true;
    package = pkgs.adwaita-icon-theme;
    dark = "Adwaita";
    light = "Adwaita";
  };

  stylix.fonts = {
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };

    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };

    monospace = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans Mono";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };

}