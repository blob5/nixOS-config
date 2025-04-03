{ config, lib, pkgs, ... }:

{
  # Import common Hyprland configuration
  imports = [
    ../../common/hypr/hyprland.nix
  ];

  # Host-specific Hyprland settings
  wayland.windowManager.hyprland = {
    extraConfig = ''
      # Source host-specific configurations
      source = ~/.config/hypr/monitors.conf
      source = ~/.config/hypr/input.conf

      # Navi-specific settings
      # Add any Navi-specific configurations here

      # To fix the flickering issue with Vesktop
      env = ELECTRON_ENABLE_GPU_RASTERIZATION,1
      
    '';
  };

  # Create symlinks for host-specific configurations
  home.activation.hyprlandConfig = lib.mkForce (lib.hm.dag.entryAfter ["writeBoundary"] ''
    # Create config directory if it doesn't exist
    mkdir -p ~/.config/hypr
    
    # Symlink the monitor configuration
    ln -sf ${./monitors.conf} ~/.config/hypr/monitors.conf
    
    # Symlink the input configuration
    ln -sf ${./input.conf} ~/.config/hypr/input.conf
  '');
} 