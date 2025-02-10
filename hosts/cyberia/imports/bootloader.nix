{ config, pkgs, ... }:

{
  boot.loader = {
    grub = {
      useOSProber = true;
      enable = true;
      efiSupport = true;
      device = "nodev";

      configurationLimit = 10;

      minegrub-world-sel = {
        enable = true;
        customIcons = [{
          name = "nixos";
          lineTop = "NixOS (23/10/2024, 23:03)";
          lineBottom = "Survival Mode, No Cheats, Version: 24.05";
          imgName = "nixos";
        }];
      };
    };
  };
}