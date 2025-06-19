{ config, pkgs, ... }:

{
  imports = [
    ../common/common-home.nix
    ../../modules/desktop/waybar/waybar.nix
    ../../modules/desktop/compositors/niri/niri.nix
  ];


  niri = {
    monitors = [ "eDP-1,1920x1080@60,0x0,1" "DP-1,2560x1440@144,0x0,1" ];
    input.sensitivity = 0.5;
    input.kb_layout = "us";
  };

  # Host-specific home-manager settings
  home.username = "blob";
  home.homeDirectory = "/home/blob";
  home.stateVersion = "25.05"; # Match your NixOS version
  nixpkgs.config.allowUnfree = true;

}
