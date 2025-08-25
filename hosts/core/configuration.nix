{ config, pkgs, ... }:

{
  imports =
    [
      ## Hardware configuration
      ./hardware-configuration.nix
      
      ## Services
      ../../modules/services/nixos/audio.nix

      ## Drivers
      ../../modules/drivers/amd.nix

      # Core
      ../../modules/core/default.nix

      # Packages
      ../../modules/packages/nixos/services.nix
      ../../modules/packages/nixos/syncthing.nix
      ../../modules/packages/nixos/utils.nix

    ];


  # Original install version,
  # This is only used by some packages for backwards compatibility.
  # use channels if you want to update package versions.
  # DO NOT UPDATE THIS UNLESS YOU KNOW WHAT YOU ARE DOING
  system.stateVersion = "25.05";
}
