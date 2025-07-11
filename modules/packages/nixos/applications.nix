{ config, pkgs, ... }:

{

  # System-level configurations
  environment.systemPackages = with pkgs; [

    # Applications
    better-control
    waypaper
    networkmanagerapplet
  ];

  programs.firefox.enable = true;
  programs.wireshark.enable = true;


}
