{ inputs, pkgs, systemSettings, ... }:

let
  hostSettings = import "${inputs.self}/hosts/${systemSettings.hostname}/settings.nix";
in
{
  # sddm
  services.displayManager = {
    sessionPackages = [ pkgs.${hostSettings.compositor} ];
    sddm = {
      wayland.enable = true;
      enable = true;
      theme = "where-is-my-sddm-theme";
      extraPackages = with pkgs.kdePackages; [
            qtmultimedia
            qtsvg
            qtvirtualkeyboard
        ];
      package = pkgs.kdePackages.sddm;
    };
  };
}