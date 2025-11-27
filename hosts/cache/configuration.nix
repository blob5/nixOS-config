{ config, pkgs, ... }:

{
  programs.niri.enable = true;

  imports =
    [
      ## Hardware configuration
      ./hardware-configuration.nix
      
      ## Services
      ../../modules/services/nixos/audio.nix
      ../../modules/services/nixos/sddm.nix

      # Core
      ../../modules/core/default.nix

      # Packages
      ../../modules/packages/nixos/services.nix
      ../../modules/packages/nixos/syncthing.nix
      ../../modules/packages/nixos/utils.nix
      ../../modules/packages/nixos/desktop.nix
      ../../modules/packages/nixos/applications.nix

    ];

  environment.systemPackages = with pkgs; [
    obsidian
    nautilus
    mako
    kdePackages.ark
    kdePackages.gwenview    
  ];

  services.tlp.enable = true;
  services.auto-cpufreq.enable = true;
  services.thermald.enable = true;
  hardware.enableAllFirmware = true;
  hardware.firmware = [ pkgs.iwlwifi-firmware ];
  services.xserver.libinput.enable = true;

  services.logind.extraConfig = ''
    HandleLidSwitch=suspend
  '';

  hardware.opengl = {
    enable = true;
    driSupport = true;
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
