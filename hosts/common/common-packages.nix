{ config, pkgs, ... }:

{


  imports = [

    ../../modules/core/default.nix
  ];

  # System-level configurations
  environment.systemPackages = with pkgs; [

    # System utils
    killall
    file
    wireguard-tools
    dconf
    inetutils
    ripgrep


    # System Services
    gnome-bluetooth
    swww
    brightnessctl
    bluez
    bluez-tools
    lm_sensors
    iw
    home-manager


    # sddm
    catppuccin-sddm
    sddm-astronaut

    

    # Applications
    better-control
    waypaper
    networkmanagerapplet
    
    # Desktop
    waylock
    swaynotificationcenter
    playerctl
    hyprshot
    libnotify
    slurp
    wl-clipboard
    pavucontrol
    blueman

  ];

	systemd.user.units.swaync.enable = true;


  # waylock PAM configuration
  security.pam.services.waylock = {
    text = ''
      auth      include login
      account   include login
      password  include login
      session   include login
    '';
  };

  # Programs
  programs.wireshark.enable = true;
  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.zsh.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };


  # Services
  programs.nix-ld.enable = true;

  services.envfs.enable = true;

  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "blob";
    dataDir = "/home/blob";
  };
}
