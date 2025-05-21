{ config, pkgs, ... }:

{
  # System-level configurations
  environment.systemPackages = with pkgs; [
    git
    nodejs
    neofetch
    fastfetch
    zed-editor
    oh-my-posh
    zsh-autosuggestions    
    zsh-syntax-highlighting
    wl-clipboard
    catppuccin-sddm
    ghostty
    home-manager
  ];

  programs.wireshark.enable = true;

  # Common nix modules
  programs.firefox.enable = true;
  programs.fish.enable = true;
  programs.zsh.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "blob";
    dataDir = "/home/blob";
  };
}
