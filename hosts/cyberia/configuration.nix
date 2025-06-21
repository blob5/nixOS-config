{ config, pkgs, ... }:

{
  
  programs.niri.enable = true;

  imports =
    [
      ## Services
      ../../modules/services/audio.nix
      ../../modules/services/sddm.nix

      ## Hardware configuration
      ./hardware-configuration.nix
      
      ## 
      ../common/common-packages.nix
      ../../modules/drivers/amd.nix
    ];

  environment.systemPackages = with pkgs; [
    xwayland-satellite # For XWayland support
  ];


  # Original install version,
  # This is only used by some packages for backwards compatibility.
  # use channels if you want to update package versions.
  # DO NOT UPDATE THIS UNLESS YOU KNOW WHAT YOU ARE DOING
  system.stateVersion = "24.05";
}
