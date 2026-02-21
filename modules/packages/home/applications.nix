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
      kdePackages.qttools # Qt development tools required for KDE connect noctalia plugin
      qbittorrent # Torrent client
      vlc # Media player
      foliate # E reader
      superfile # Terminal file manager
      obsidian # Note-taking app
      mako # Notification daemon
      moonlight-qt # Game streaming client
      heroic # Game launcher
      remmina # Remote desktop client
      lutris # Game manager
      element-desktop # Matrix client
      gnome-calculator
      baobab # Disk usage analyzer
      tesseract4 # image to text engine
    ];
  };
}
