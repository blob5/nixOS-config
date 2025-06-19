{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports = [
    ../common/common-home.nix
    ../../modules/services/easyeffects.nix
    ../../modules/desktop/compositors/hyprland/hyprland.nix
  ];



  hyprland = {
    monitors = [ "DP-1,2560x1440@165,0x0,1" "HDMI-A-2,1920x1080@75,2560x-130,1,transform,3" ];
    input.sensitivity = -0.75;
    input.kb_layout = "us";
    accel_profile = "flat";
  };




  # Host-specific home-manager settings
  home.username = "blob";
  home.homeDirectory = "/home/blob";
  home.stateVersion = "25.05"; # Match your NixOS version

  # audio effects and filters
  services.easyeffects.enable = true;


  # Host-specific git settings
  programs.git = {
    enable = true;
    userName = "blob5";
    signing = {
      key = "F0D60667EEF767DF";
      signByDefault = true;
    };
  };
}
