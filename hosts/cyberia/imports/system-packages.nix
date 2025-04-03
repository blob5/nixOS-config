{ config, pkgs, ... }:

{
  # Host-specific system packages
  environment.systemPackages = with pkgs; [
    # Add any Cyberia-specific packages here
  ];

  # Host-specific nix modules
  # Add any Cyberia-specific module configurations here
}
