{ config, lib, pkgs, ... }: {

  home.packages = [
    # pkgs.hyprpaper
    # pkgs.hypridle
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };
}
