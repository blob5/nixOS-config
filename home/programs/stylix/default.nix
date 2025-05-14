{ config, pkgs, lib, ... }:

{
  stylix.enable = true;

  stylix.autoEnable = false;

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

  stylix.targets = {
    gtk.enable = true;
    kde.enable = true;
    mpv.enable = true;
  };
}
