{ config, pkgs, ... }:

{
  # nix packages
  environment.systemPackages = with pkgs; [
    git
    nodejs
    kitty
    neofetch
    zed-editor
    oh-my-posh
    wl-clipboard
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
