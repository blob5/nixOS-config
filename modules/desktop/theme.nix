{ config, pkgs, lib, ... }:

{
  gtk = {
    enable = true;

    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    font = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
      size = 11;
    };

    gtk3.extraCss = ''
      /* Button styling - ensures readable text */
      button {
        color: @theme_fg_color;
        background-color: @theme_bg_color;
        border: 0.1em solid @borders;
      }
    '';

    gtk4.extraCss = ''
      /* Button styling - ensures readable text */
      button {
        color: @theme_fg_color;
        background-color: @theme_bg_color;
        border: 0.1em solid @borders;
      }
    '';
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

}
