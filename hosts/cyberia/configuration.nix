{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      #package = pkgs.bluez5-experimental;
      package = pkgs.bluez;
      settings.Policy.AutoEnable = "true";
      settings.General = {
          Enable = "Source,Sink,Media,Socket";
          Name = "Hello";
          ControllerMode = "dual";
          FastConnectable = "true";
          Experimental = "true";
          KernelExperimental = "true";
      };
    };
  
  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8"; # AM and PM but dd/mm/yy

  time.timeZone = "Europe/Amsterdam";

  imports =
    [
      ../../modules/core/boot.nix

      ./hardware-configuration.nix
      
      ./imports/amd-drivers.nix
      ./imports/networking.nix
      ./imports/services.nix
      ./imports/system-packages.nix
      ./imports/users.nix
      ../common/common-packages.nix
      ../common/common-configuration.nix

    ];

  system.stateVersion = "24.05";
}
