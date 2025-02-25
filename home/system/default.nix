# home/system/default.nix
{ config, lib, pkgs, ... }: {
  imports = [
    ./hyprland
    ./hyprpanel
    #./hyprlock
    ./rofi
  ];
}
