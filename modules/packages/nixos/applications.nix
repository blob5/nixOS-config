{ config, pkgs, ... }:

{

  # System-level configurations
  environment.systemPackages = with pkgs; [

    # Applications
    better-control
    waypaper
    networkmanagerapplet
    protonvpn-gui
  ];

  programs.wireshark.enable = true;

}
