{ config, pkgs, ... }:

{
  services.tailscale.enable = true;

  services.displayManager.ly.enable = true;

  services.printing.enable = true;

  services.openssh.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}