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
      theme = "where_is_my_sddm_theme";
      extraPackages = with pkgs.kdePackages; [
            qtmultimedia
            qtsvg
            qtvirtualkeyboard
        ];
      package = pkgs.kdePackages.sddm;
    };
  };
}