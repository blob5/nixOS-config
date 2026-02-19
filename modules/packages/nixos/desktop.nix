{ config, pkgs, ... }:

{

  # System-level configurations
  environment.systemPackages = with pkgs; [

    
    # Desktop
    waylock
    playerctl
    libnotify
    slurp # Screenshot selection tool
    grim # Screenshot tool
    wl-clipboard
    pavucontrol
    blueman
    wlsunset
  ];
}
