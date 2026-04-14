{ config, pkgs, ... }:

{
  imports = [
    ## Hardware configuration
    ./hardware-configuration.nix

    ../common/system/base.nix

    ## Services
    ../../modules/services/nixos/audio.nix

    ## Drivers
    ../../modules/drivers/amd.nix

  ];
  networking.firewall.allowedTCPPorts = [ 19400 ]; # for hyperion

  # Original install version,
  # This is only used by some packages for backwards compatibility.
  # use channels if you want to update package versions.
  # DO NOT UPDATE THIS UNLESS YOU KNOW WHAT YOU ARE DOING
  system.stateVersion = "25.05";
}
