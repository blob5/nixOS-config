{ config, pkgs, lib, ... }:

{
  stylix.enable = true;

  stylix.autoEnable = false;

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";

  stylix.polarity = "dark";

  stylix.targets = {
    gtk.enable = true;
    kde.enable = true;
    qt = {
      enable = true;
      platform = "qtct";
    };
    vesktop.enable = true;
    spicetify.enable = true;
  };

  stylix.targets.gtk.extraCss = ''
    /* Button styling - ensures readable text */
    button {
      color: @theme_fg_color;
      background-color: @theme_bg_color;
      border: 0.1em solid @borders;
    }
  '';

  stylix.iconTheme ={
    enable = true;
    package = pkgs.papirus-icon-theme;
    dark = "Papirus-Dark";
    light = "Papirus-Light";
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
