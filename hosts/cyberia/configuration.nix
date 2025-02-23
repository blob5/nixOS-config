{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  
  time.timeZone = "Europe/Amsterdam";

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
