{ config, pkgs, ... }:

{

  # System-level configurations
  environment.systemPackages = with pkgs; [

    # Applications
    better-control
    waypaper
    networkmanagerapplet
    wireshark
  ];

  programs.wireshark = {
    dumpcap.enable = true;
    enable = true;
  };

  programs.kdeconnect.enable = true;

}
