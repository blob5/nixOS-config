{ pkgs, systemSettings, ... }:

let
  hostSettings = import ../../hosts/${systemSettings.hostname}/settings.nix;
in
{
  # sddm
  services.displayManager = {
    sessionPackages = [ pkgs.${hostSettings.compositor} ];
    sddm = {
      wayland.enable = true;
      enable = true;
      theme = "sddm-astronaut-theme";
      extraPackages = with pkgs; [
            kdePackages.qtmultimedia
            kdePackages.qtsvg
            kdePackages.qtvirtualkeyboard
        ];
      package = pkgs.kdePackages.sddm;
    };
  };
}