{ config, pkgs, ... }:

let
  hyprlandModule = import ../common/hyprland.nix { hostname = "cyberia"; };
in
{
  imports = [
    ../common/common-home.nix
    hyprlandModule
  ];

  # Host-specific home-manager settings
  home.username = "blob";
  home.homeDirectory = "/home/blob";
  home.stateVersion = "25.05"; # Match your NixOS version
}
