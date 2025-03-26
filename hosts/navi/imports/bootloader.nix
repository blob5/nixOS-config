{ config, pkgs, ... }:

{
  boot.plymouth.enable = true;
  boot.plymouth.theme = "dark_planet";
  boot.plymouth.themePackages = [ pkgs.adi1090x-plymouth-themes ];
  
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
          lineTop = "NixOS (Thu Nov 21 21:44:02 2024)";
          lineBottom = "Survival Mode, No Cheats, Version: 24.11";
          imgName = "nixos";
        }];
      };
    };
  };
}
