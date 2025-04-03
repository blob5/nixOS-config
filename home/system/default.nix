# home/system/default.nix
{ config, lib, pkgs, ... }: {
  imports = [
    ./hyprpanel
    #./hyprlock
    ./rofi
  ];
}
