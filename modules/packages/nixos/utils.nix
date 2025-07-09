{ config, pkgs, ... }:

{

  # System-level configurations
  environment.systemPackages = with pkgs; [

    # System utils
    killall
    file
    wireguard-tools
    dconf
    inetutils
    ripgrep

  ];
}
