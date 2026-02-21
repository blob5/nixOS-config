{ config, pkgs, ... }:

{

  # System-level configurations
  environment.systemPackages = with pkgs; [

    # Applications
    better-control
    waypaper
    networkmanagerapplet
  ];

  programs.wireshark.enable = true;

  programs.kdeconnect.enable = true;

}
