{ config, pkgs, ... }:

{
  services.tailscale.enable = true;

  programs.steam.enable = true;

  services.printing.enable = true;

  services.openssh.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}