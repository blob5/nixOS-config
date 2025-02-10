{
  environment.systemPackages = with pkgs; [
    git
    nodejs
    kitty
    neofetch
    programs.firefox.enable = true;
  ];
}