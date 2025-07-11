{ config, pkgs, ... }:

{


  imports =
    [
      ./hardware-configuration.nix

      # Programs/services/modules
      ../../modules/virtualization/virtualization.nix

      # Core
      ../../modules/core/default.nix

      # Packages
      ../../modules/packages/nixos/syncthing.nix
      ../../modules/packages/nixos/utils.nix
      ../../modules/packages/nixos/services.nix
    ];


  # Host-specific system packages
  environment.systemPackages = with pkgs; [

  ];

  # Original install version,
  # This is only used by some packages for backwards compatibility.
  # use channels if you want to update package versions.
  # DO NOT UPDATE THIS UNLESS YOU KNOW WHAT YOU ARE DOING
  system.stateVersion = "None";
}
