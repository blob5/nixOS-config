{ pkgs, ... }:

{
  home.file.".config/rofi/spotlight-dark.rasi".source = ./spotlight-dark.rasi;

  home.file.".config/rofi/powermenu/powermenu.rasi".source = powermenu/powermenu.rasi;

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = "~/.config/rofi/spotlight-dark.rasi";
  };


  # for rofi-emoji to insert emojis directly
  home.packages = [ pkgs.xdotool ];
}
