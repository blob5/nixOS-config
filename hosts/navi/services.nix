{ ... }:

{

  imports = [
    ../../modules/services/audio.nix
    ../../modules/services/sddm.nix
    ../../modules/core/services.nix
  ];

  services.sunshine = {
    enable = true;
    autoStart = false;
    capSysAdmin = true;
    openFirewall = true;
  };

  services.hardware.openrgb.enable = true;

}