{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./imports/amd-drivers.nix
      ./imports/bootloader.nix
      ./imports/internationalization.nix
      ./imports/networking.nix
      ./imports/services.nix
      ./imports/system-packages.nix
      ./imports/users.nix
    ];

  system.stateVersion = "24.05";
  system = "x86_64-linux";
