{ config, pkgs, ... }:

{
  services.tailscale.enable = true;

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
    
  };

  virtualisation.docker.enable = true;  

  services.displayManager = {
    sessionPackages = [pkgs.hyprland];
    sddm = {
      wayland.enable = true;
      enable = true;
      theme = "catppuccin-mocha";
      package = pkgs.kdePackages.sddm;
    };
  };
  services.printing.enable = true;

  services.openssh.enable = true;
 
  programs.sway.enable = true;

  services.upower.enable = true; # needed for hyprpanel
   
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
