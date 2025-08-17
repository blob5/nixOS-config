{ inputs, pkgs, systemSettings, userSettings, ... }: 

{
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];
  programs.zen-browser.enable = true;


  home = {
    packages = with pkgs; [
 
      # Media & Applications
      nautilus # File manager
      kdePackages.ark # Archive manager
      kdePackages.gwenview # Image viewer
      qbittorrent
      vlc
      foliate # E reader
      libreoffice-qt
      superfile
      obsidian
      inputs.nixvim.packages.x86_64-linux.default
      picard
      mako
    ];
  };
}
