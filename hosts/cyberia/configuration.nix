{ config, pkgs, ... }:

{

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
}