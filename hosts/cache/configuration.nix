{ config, pkgs, ... }:

{
  programs.niri.enable = true;

  imports = [
    ## Hardware configuration
    ./hardware-configuration.nix

    ../common/system/graphical.nix

  ];

  environment.systemPackages = with pkgs; [
    obsidian
    nautilus
    kdePackages.ark
    kdePackages.gwenview
  ];

  services.thermald.enable = true;
  hardware.enableAllFirmware = true;
  services.libinput.enable = true;

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
    ];
  };

  # Original install version,
  # This is only used by some packages for backwards compatibility.
  # use channels if you want to update package versions.
  # DO NOT UPDATE THIS UNLESS YOU KNOW WHAT YOU ARE DOING
  system.stateVersion = "25.05";
}
