{ pkgs, systemSettings, ... }:

let
  hostSettings = import ../../hosts/${systemSettings.hostname}/settings.nix;
in
{
  # sddm
  services.displayManager = {
    sessionPackages = with pkgs; [systemSettings.compositor];
    sddm = {
      wayland.enable = true;
      enable = true;
      theme = "catppuccin-mocha";
      package = pkgs.kdePackages.sddm;
    };
  };
}