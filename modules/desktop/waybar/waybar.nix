{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      configFile = ./config.json;
      style = builtins.readFile ./theme.css;
    };
    package = pkgs.waybar;
  };
}
