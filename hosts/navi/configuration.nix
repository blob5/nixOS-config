{ config, pkgs, ... }:

{


  imports =
    [
      ./hardware-configuration.nix

      # Programs/services/modules
      ../../modules/virtualization/virtualization.nix
      ../../modules/programs/gaming/steam.nix
      ../../modules/programs/gaming/minecraft.nix
      ../../modules/programs/wine.nix

      # Services
      ../../modules/services/nixos/audio.nix
      ../../modules/services/nixos/sddm.nix
      ../../modules/services/nixos/sunshine.nix


      # Core
      ../../modules/core/default.nix
      ../../modules/drivers/amd.nix



      # Packages
      ../../modules/packages/nixos/services.nix
      ../../modules/packages/nixos/syncthing.nix
      ../../modules/packages/nixos/utils.nix
      ../../modules/packages/nixos/desktop.nix
      ../../modules/packages/nixos/applications.nix
    ];

  programs.hyprland.enable = true;
  services.hardware.openrgb.enable = true;
  services.hardware.openrgb.motherboard = "amd";
  services.hardware.openrgb.package = pkgs.openrgb-with-all-plugins;

  hardware.wooting.enable = true;
  services.lact.enable = true; # AMD overclocking tool
  hardware.amdgpu.overdrive.enable = true; # Enable AMD overclocking functionality

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

  # Host-specific system packages
  environment.systemPackages = with pkgs; [
    # Drawing
    opentabletdriver
    
    darktable # color grading
    pwntools
    gdb
    blender
    davinci-resolve
    ungoogled-chromium # for wooting
    bottles
  ];

  # Original install version,
  # This is only used by some packages for backwards compatibility.
  # use channels if you want to update package versions.
  # DO NOT UPDATE THIS UNLESS YOU KNOW WHAT YOU ARE DOING
  system.stateVersion = "24.11";
}
