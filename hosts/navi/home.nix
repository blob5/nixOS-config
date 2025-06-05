{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports = [
    ../common/common-home.nix
    ./hypr/hyprland.nix
    ../../modules/services/easyeffects.nix

  ];

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
      key = "12E0BF53BFD81E3F";
      signByDefault = true;
    };
  };
}
