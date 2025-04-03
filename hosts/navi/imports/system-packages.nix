{ config, pkgs, ... }:

{
  # Host-specific system packages
  environment.systemPackages = with pkgs; [
    # Add any Navi-specific packages here
  ];

  # Host-specific nix modules
  # Add any Navi-specific module configurations here
}
