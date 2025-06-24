# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{


  imports =
    [
      ./hardware-configuration.nix

      ../../modules/virtualization/virtualization.nix
      ../common/common-packages.nix
      ../../modules/programs/gaming/steam.nix
      ../../modules/drivers/nvidia.nix

      ../../modules/services/audio.nix
      ../../modules/services/sddm.nix

    ];

  programs.hyprland.enable = true;
  services.hardware.openrgb.enable = true;

  services.sunshine = {
    enable = true;
    autoStart = false;
    capSysAdmin = true;
    openFirewall = true;
  };


  # Host-specific system packages
  environment.systemPackages = with pkgs; [
    # Drawing
    krita
    opentabletdriver

    # Development
    pwntools
    gdb
    # blender
  ];

  # Original install version,
  # This is only used by some packages for backwards compatibility.
  # use channels if you want to update package versions.
  # DO NOT UPDATE THIS UNLESS YOU KNOW WHAT YOU ARE DOING
  system.stateVersion = "24.11";
}
