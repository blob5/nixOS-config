# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.download-buffer-size = 524288000; # 500 MiB
  nixpkgs.config.allowUnfree = true;

  imports =
    [
      ./hardware-configuration.nix

      ./services.nix
      ../../modules/virtualization/virtualization.nix
      ../common/common-packages.nix
      ../common/common-configuration.nix
      ../../modules/programs/gaming/steam.nix
      ../../modules/programs/media-tools/media-tools.nix
      ../../modules/drivers/nvidia.nix
    ];


  programs.hyprland.enable = true;

  systemd.user.units.swaync.enable = true;

  # Host-specific system packages
  environment.systemPackages = with pkgs; [
    # Drawing
    krita
    opentabletdriver

    # Development
    pwntools
    gdb
    swaynotificationcenter
    (blender.override {
      cudaSupport = true;
    })
  ];

  system.stateVersion = "24.11";
}
