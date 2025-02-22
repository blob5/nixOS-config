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
    
    # development
    openjdk
    python312

    # system
    papirus-icon-theme
    killall
    pkgs.gnome-bluetooth

    # terminal stuff
    foot
    starship
    wezterm
 
    # programs
    vesktop # Modded discord client
    waypaper # wallpaper utility
    swww # wallpaper backend 
    obsidian # note app

    # Utils
    htop # process viewer
    networkmanagerapplet # networkmanager util
    git
    unzip
    wget

    # Tomfoolery
    nmap
    traceroute
    whois
    dig
    metasploit
    iw
    aircrack-ng
    inetutils # telnet
    john
    hashcat
    gobuster
    

    # because I can
    sl
    cowsay
    cmatrix
    hollywood
    aalib
    pipes
    asciiquarium-transparent
    # bsdgames
    
    # text/code editors/readers
    vim
    vscode
    neovide
    neovim
   
    ]);
  };

  programs.git = {
    enable = true;
    userName = "blob";
    userEmail = "101657201+blob5@users.noreply.github.com";
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
}
