{ config, pkgs, ... }:

{
  services.tailscale.enable = true;

  services.sunshine = {
    enable = true;
    autoStart = false;
    capSysAdmin = true;
    openFirewall = true;
  };

  virtualisation.docker.enable = true;  

  services.displayManager = {
    sessionPackages = [pkgs.hyprland pkgs.niri];
    sddm = {
      wayland.enable = true;
      enable = true;
      theme = "catppuccin-mocha";
      package = pkgs.kdePackages.sddm;
    };
  };
  services.printing.enable = true;

  services.openssh.enable = true;
 
  services.upower.enable = true; # needed for hyprpanel
   
  services.pcscd.enable = true; # needed for gpg

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    
    # Disable Automatic Gain Control (AGC)
    extraConfig.pipewire = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 32;
        "default.clock.min-quantum" = 32;
        "default.clock.max-quantum" = 32;
      };
    };
    
    extraConfig.pipewire-pulse = {
      "context.modules" = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = {
            "pulse.min.req" = "32/48000";
            "pulse.default.req" = "32/48000";
            "pulse.max.req" = "32/48000";
            "pulse.min.quantum" = "32/48000";
            "pulse.max.quantum" = "32/48000";
            "pulse.min.frag" = "1";
          };
        }
      ];
      
      # Disable echo cancellation and automatic gain control
      "stream.properties" = {
        "node.latency" = "32/48000";
        "resample.quality" = 1;
        # Disable echo cancellation
        "channelmix.normalize" = false;
        "channelmix.mix-lfe" = false;
        "channelmix.upmix" = false;
        "channelmix.lfe-cutoff" = 0;
        # Disable automatic gain control
        "session.suspend-timeout-seconds" = 5;
        "node.autoconnect" = true;
      };
    };
  };
}
