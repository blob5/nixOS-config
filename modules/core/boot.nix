{ config, pkgs, lib, systemSettings, ... }:

let
  hostSettings = import ../../hosts/${systemSettings.hostname}/settings.nix;
in
{

  # Disable Stylix Plymouth styling to prevent conflicts
  stylix.targets.plymouth.enable = false;


  # Enable Plymouth for a graphical boot splash
  boot.plymouth = {
    enable = true;
    theme = lib.mkForce "dark_planet";
    themePackages = [ pkgs.adi1090x-plymouth-themes ];
  };

  # if hasNvidia is true, add nvidia_drm.modeset=1 to kernel parameters
  boot.kernelParams = if hostSettings.hasNvidia then [ "nvidia_drm.modeset=1" ] else [];

  boot.loader = {
    grub = {
      useOSProber = true;
      enable = true;
      efiSupport = hostSettings.bootloader.efiSupport;
      device = "${hostSettings.bootloader.device}";

      configurationLimit = 10;

      minegrub-world-sel = {
        enable = true;
        customIcons = [{
          name = "nixos";
          lineTop = "NixOS (${hostSettings.fileSystemCreationDate})";
          lineBottom = "Survival Mode, No Cheats, Version: ${hostSettings.version}";
          imgName = "nixos";
        }];
      };
    };
  };
}