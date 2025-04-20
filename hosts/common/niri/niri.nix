{ config, lib, pkgs, ... }:

{
  wayland.windowManager.niri = {
    enable = true;

    # Optional if you want to specify your main config file
    # configFile = ./niri.kdl;
  };

  home.packages = with pkgs; [
    niri
    # Optional dependencies
    wlr-randr   # for display configuration
    wl-clipboard
    xdg-utils
  ];

  # Optional: Set environment variables for Niri or Wayland apps
  home.sessionVariables = {
    NIRI_LOG = "info";  # or debug/warn/error
    # Example: make Firefox use wayland
    MOZ_ENABLE_WAYLAND = "1";
  };

  # Optional: enable D-Bus user session if needed
  systemd.user.services.dbus.enable = true;

  # Optional: input/output config folders (symlinks to host-specific files will override)
  home.file.".config/niri/monitors.kdl".text = ''
    # Default monitor setup (overridden by host if symlinked)
  '';

  home.file.".config/niri/input.kdl".text = ''
    # Default input setup (overridden by host if symlinked)
  '';
}
