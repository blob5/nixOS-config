{ config, pkgs, ... }:

{
  imports = [
    ../common/common-home.nix
    ./hypr/hyprland.nix
    ./hypr/hyprpanel.nix
  ];

  # Host-specific home-manager settings
  home.username = "blob";
  home.homeDirectory = "/home/blob";
  home.stateVersion = "25.05"; # Match your NixOS version
}
