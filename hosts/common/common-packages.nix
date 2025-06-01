{ config, pkgs, ... }:

{
  # System-level configurations
  environment.systemPackages = with pkgs; [
    git
    nodejs
    fastfetch
    zed-editor
    catppuccin-sddm
    sddm-astronaut
    ghostty
    home-manager

    nixfmt-rfc-style

    mpv
    mpvScripts.uosc
    mpvScripts.thumbfast

  ];



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
