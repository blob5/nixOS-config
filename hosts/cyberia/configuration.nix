{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
    

  imports =
    [

      ./services.nix

      ./hardware-configuration.nix
      
      ./imports/system-packages.nix
      ../common/common-packages.nix
      ../common/common-configuration.nix
      ../../modules/drivers/amd.nix
    ];

  system.stateVersion = "24.05";
}
