{ config, lib, pkgs, ... }: {
  home.packages = [
    pkgs.font-awesome
    pkgs.nerd-fonts.jetbrains-mono
  ];
}
