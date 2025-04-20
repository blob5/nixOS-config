{ config, lib, pkgs, ... }:

{
  # Import common niri configuration
  imports = [
    ../../common/niri/niri.nix
  ];

  # Host-specific Niri settings
  wayland.windowManager.niri = {
    enable = true;

    extraConfig = ''
	  # Source host-specific configurations
	  source = ~/.config/niri/monitors.kdl
	  source = ~/.config/niri/input.kdl

	  # Cyberia-specific settings
	  # Add any Cyberia-specific configurations here
  };

  # Create symlinks for host-specific Niri configurations
  home.activation.niriConfig = lib.mkForce (lib.hm.dag.entryAfter ["writeBoundary"] ''
    # Create config directory if it doesn't exist
    mkdir -p ~/.config/niri

    # Symlink the monitor configuration
    ln -sf ${./monitors.kdl} ~/.config/niri/monitors.kdl

    # Symlink the input configuration
    ln -sf ${./input.kdl} ~/.config/niri/input.kdl
  '');
}