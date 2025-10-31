{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    papirus-icon-theme
    font-awesome
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    symbola
    gnome-icon-theme
    adwaita-icon-theme
    roboto
    roboto-mono
    dejavu_fonts
    inter-nerdfont
    material-symbols
  ];

  fonts.fontconfig.enable = true;
}
