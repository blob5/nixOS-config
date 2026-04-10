{ pkgs, ... }:

{
  home.file.".config/rofi/spotlight-dark.rasi".source = ./spotlight-dark.rasi;


  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    theme = "~/.config/rofi/spotlight-dark.rasi";
    plugins = [ pkgs.rofi-calc ];
  };

  # for rofi-emoji to insert emojis directly
  home.packages = with pkgs; [
      xdotool
    ];
}
