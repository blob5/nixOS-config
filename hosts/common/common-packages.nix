{ config, pkgs, ... }:

{
  # System-level configurations
  environment.systemPackages = with pkgs; [
    git
    nodejs
    kitty
    neofetch
    fastfetch
    zed-editor
    oh-my-posh
    zsh-autosuggestions    
    zsh-syntax-highlighting
    wl-clipboard
    catppuccin-sddm
  ];

  # Common nix modules
  programs.firefox.enable = true;
  programs.steam.enable = true;
  programs.fish.enable = true;
  programs.zsh.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
  };
}
