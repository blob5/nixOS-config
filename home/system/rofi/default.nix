{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    # theme = builtins.toPath ./spotlight-dark.rasi;
  };
   
  
  # for rofi-emoji to insert emojis directly
  home.packages = [ pkgs.xdotool ];
}
