{ config, pkgs, ... }:

{
  # Host-specific system packages
  environment.systemPackages = with pkgs; [
    # Drawing
    krita
    opentabletdriver

    # Development
    pwntools
    gdb
  ];

  # Host-specific nix modules
  # Add any Navi-specific module configurations here
}
