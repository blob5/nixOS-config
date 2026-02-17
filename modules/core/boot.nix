{
  config,
  pkgs,
  lib,
  systemSettings,
  ...
}:

let
  hostSettings = import ../../hosts/${systemSettings.hostname}/settings.nix;
  cpuVendor = hostSettings.cpuVendor or null;
in
{

  # Disable Stylix Plymouth styling to prevent conflicts
  stylix.targets.plymouth.enable = false;

  boot.extraModulePackages = with config.boot.kernelPackages;
    lib.mkIf (cpuVendor == "amd") [ zenpower ];

  # Enable Plymouth for a graphical boot splash
  boot.plymouth = {
    enable = true;
    theme = lib.mkForce "dark_planet";
    themePackages = [ pkgs.adi1090x-plymouth-themes ];
  };


  boot.loader = {
    efi.canTouchEfiVariables = hostSettings.bootloader.efiSupport;
    grub = {
      useOSProber = true;
      enable = true;
      efiSupport = hostSettings.bootloader.efiSupport;
      device = "${hostSettings.bootloader.device}";

      configurationLimit = 5;

      minegrub-world-sel = {
        enable = true;
        customIcons = [
          {
            name = "nixos";
            lineTop = "NixOS (${hostSettings.fileSystemCreationDate})";
            lineBottom = "Survival Mode, No Cheats, Version: ${hostSettings.version}";
            imgName = "nixos";
          }
        ];
      };
    };
  };
}
