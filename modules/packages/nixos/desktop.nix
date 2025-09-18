{ config, pkgs, ... }:

{

  # System-level configurations
  environment.systemPackages = with pkgs; [

    
    # Desktop
    waylock
    playerctl
    hyprshot
    libnotify
    slurp
    wl-clipboard
    pavucontrol
    blueman
    wlsunset
  ];
}
