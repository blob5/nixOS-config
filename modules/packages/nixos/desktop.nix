{ config, pkgs, ... }:

{

  # System-level configurations
  environment.systemPackages = with pkgs; [

    
    # Desktop
    waylock
    swaynotificationcenter
    playerctl
    hyprshot
    libnotify
    slurp
    wl-clipboard
    pavucontrol
    blueman
  ];
}
