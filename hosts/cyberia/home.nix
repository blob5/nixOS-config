{ inputs, pkgs, systemSettings, userSettings, ... }: {
  imports = [
    ../../home/system
    ../../home/programs
    ../../home/wallpapers
  ];
  

  home = {
    username = userSettings.username;
    homeDirectory = "/home/"+userSettings.username;
    stateVersion = systemSettings.version;
    
    packages = (with pkgs; [
    # essentials
    git
    
    # programs
    vesktop # Modded discord client
    waypaper # wallpaper utility
    swww # wallpaper backend 
    
    # Utils
    htop # process viewer
    networkmanagerapplet # networkmanager util

    # Tomfoolery
    nmap
    traceroute
    whois
    dig
    metasploit
    iw
    aircrack-ng

    # because I can
    sl
    cowsay
    cmatrix
    hollywood
    aalib
    
    # text/code editors/readers
    vim
    vscode
    neovide

    # Languages
    python312
   
    ]);
  };


  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
}
