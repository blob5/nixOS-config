{ config, pkgs, ... }:

{
  programs.niri.enable = true;

  programs.uwsm = {
    enable = true;
    waylandCompositors.niri = {
      prettyName = "Niri";
      comment = "Niri compositor managed by UWSM";
      binPath = "/run/current-system/sw/bin/niri-session";
    };
  };

  imports = [
    ## Hardware configuration
    ./hardware-configuration.nix

    ../common/system/graphical.nix

    ## Drivers
    ../../modules/drivers/amd.nix

  ];

  environment.systemPackages = with pkgs; [
    xwayland-satellite # For XWayland support
  ];

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

  programs.virt-manager.enable = true;

  # Original install version,
  # This is only used by some packages for backwards compatibility.
  # use channels if you want to update package versions.
  # DO NOT UPDATE THIS UNLESS YOU KNOW WHAT YOU ARE DOING
  system.stateVersion = "24.05";
}
