{ config, pkgs, ... }:

let
  hyprlandModule = import ../common/hyprland.nix { hostname = "navi"; };
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
