{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  programs.niri.enable = true;

  imports =
    [

      ./services.nix

      ./hardware-configuration.nix
      
      ../common/common-packages.nix
      ../common/common-configuration.nix
      ../../modules/drivers/amd.nix
    ];

  environment.systemPackages = with pkgs; [
    xwayland-satellite # For XWayland support
  ];

  system.stateVersion = "24.05";
}
