{ inputs, pkgs, ... }:

# Hyprpaper is used to set the wallpaper on the system
{


  environment.systemPackages = with pkgs; [
    hyprlock
    hypridle
    hyprpaper
  ];



  # The wallpaper is set by stylix
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;
    };
  };
}
