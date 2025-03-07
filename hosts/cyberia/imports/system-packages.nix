{ config, pkgs, ... }:

{
  # nix packages
  environment.systemPackages = with pkgs; [
    git
    nodejs
    kitty
    neofetch
    fastfetch

    # editor
    zed-editor

    # Terminal theme
    oh-my-posh
    # zsh plugins
    zsh-autosuggestions    
    zsh-syntax-highlighting

    # Util
    wl-clipboard
    

    # sddm theme
    catppuccin-sddm

  ];

  # nix modules
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
