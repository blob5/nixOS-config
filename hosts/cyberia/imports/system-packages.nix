{

  # nix packages
  environment.systemPackages = with pkgs; [
    git
    nodejs
    kitty
    neofetch
  ];

  # nix modules
  programs.firefox.enable = true;
  programs.steam.enable = true;

}