{ config, pkgs, ... }:

{
  # Host-specific system packages
  environment.systemPackages = with pkgs; [
    # Notification daemon
    mako
  ];

  # Host-specific nix modules
  # Add any Cyberia-specific module configurations here
}
