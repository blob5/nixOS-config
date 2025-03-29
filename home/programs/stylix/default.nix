{ config, pkgs, lib, ... }:

{
  stylix.enable = true;
  stylix.image = ../../../wall/gruvbox_girl.png;
  stylix.targets.rofi.enable = false;
  stylix.targets.spicetify.enable = false;
}
