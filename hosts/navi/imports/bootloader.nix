{ config, pkgs, ... }:

{
  boot.plymouth.enable = true;
  boot.plymouth.theme = "dark_planet";
  boot.plymouth.themePackages = [ pkgs.adi1090x-plymouth-themes ];
  
  boot.kernelParams = [ "nvidia_drm.modeset=1" ];

  boot.loader = {
    grub = {
      useOSProber = true;
      enable = true;
      efiSupport = false;
      device = "/dev/nvme0n1";

      configurationLimit = 10;

      minegrub-world-sel = {
        enable = true;
        customIcons = [{
          name = "nixos";
          lineTop = "NixOS (Mon Mar 24 18:17:35 2025)";
          lineBottom = "Survival Mode, No Cheats, Version: 24.11";
          imgName = "nixos";
        }];
      };
    };
  };
}
