{ inputs, pkgs, systemSettings, userSettings, ... }: 

{
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];
  programs.zen-browser.enable = true;



  home = {
    packages = with pkgs; [
      # Quickshell Noctalia configuration
      inputs.noctalia.packages.${system}.default

      # Media & Applications
      nautilus # File manager
      kdePackages.ark # Archive manager
      kdePackages.gwenview # Image viewer
      qbittorrent
      vlc
      foliate # E reader
      superfile
      obsidian
      mako
      moonlight-qt
      heroic # Game launcher
      remmina # Remote desktop client
      lutris
      morgen
      element-desktop
      gnome-calculator
    ];
  };
}
