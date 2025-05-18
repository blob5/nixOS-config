{ config, pkgs, lib, ... }:

{  
  boot.kernelParams = [ "nvidia_drm.modeset=1" ];


  stylix.targets.plymouth.enable = false;

  boot.plymouth = {
    enable = true;
    theme = lib.mkForce "dark_planet";
    themePackages = [ pkgs.adi1090x-plymouth-themes ];
  };

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
