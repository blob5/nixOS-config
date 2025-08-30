{ config, pkgs, ... }:

{

  # System-level configurations
  environment.systemPackages = with pkgs; [

    # sddm
    where-is-my-sddm-theme

  ];
}
