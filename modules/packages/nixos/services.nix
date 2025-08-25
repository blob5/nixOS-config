{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

    # System Services
    gnome-bluetooth
    swww
    brightnessctl
    bluez
    bluez-tools
    lm_sensors
    iw
    home-manager
    ddcutil # for controlling monitor settings
    gpu-screen-recorder
  ];

  services.envfs.enable = true;
  programs.nix-ld.enable = true;
  programs.zsh.enable = true;
  services.frp.enable = true;
  services.frp.role = "client";

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # waylock PAM configuration
  security.pam.services.waylock = {
    text = ''
      auth      include login
      account   include login
      password  include login
      session   include login
    '';
  };
}
