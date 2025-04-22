{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    papirus-icon-theme
    font-awesome
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    symbola
    twemoji-color-font
    fira-code
    fira-code-symbols
  ];

  fonts.fontconfig.enable = true;
}
