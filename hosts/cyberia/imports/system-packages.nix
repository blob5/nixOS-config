{ config, pkgs, ... }:

{
  # Host-specific system packages
  environment.systemPackages = with pkgs; [
  ];

  # Host-specific nix modules
  # Add any Cyberia-specific module configurations here
}
