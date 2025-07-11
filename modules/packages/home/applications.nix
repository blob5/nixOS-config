{ inputs, pkgs, systemSettings, userSettings, ... }: {

  home = {
    packages = with pkgs; [
 
      # Media & Applications
      inputs.zen-browser.packages."${system}".twilight
      nautilus # File manager
      kdePackages.ark # Archive manager
      kdePackages.gwenview # Image viewer
      qbittorrent
      vlc
      foliate # E reader
      libreoffice-qt
      superfile
      obsidian
      zed-editor
      inputs.nixvim.packages.x86_64-linux.default
      tauon
      picard
    ];
  };
}
