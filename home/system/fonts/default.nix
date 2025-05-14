{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    papirus-icon-theme
    font-awesome
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    symbola
    twemoji-color-font
    gnome-icon-theme
    adwaita-icon-theme
  ];

  fonts.fontconfig.enable = true;
}
