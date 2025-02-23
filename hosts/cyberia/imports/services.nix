{ config, pkgs, ... }:

{
  services.tailscale.enable = true;

  services.displayManager.sddm.wayland.enable = true;

  services.displayManager.sddm = {
      enable = true;
      theme = "sddm-astronaut";
    };

  services.printing.enable = true;

  services.openssh.enable = true;
  
  services.pcscd.enable = true; # needed for gpg

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
