{ config, pkgs, ... }:

{

  # System-level configurations
  environment.systemPackages = with pkgs; [

    # sddm
    catppuccin-sddm
    sddm-astronaut

  ];
}
