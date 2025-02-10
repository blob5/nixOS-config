# home/programs/packages/default.nix
{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    font-awesome
    nerd-fonts.jetbrains-mono
  ];
}