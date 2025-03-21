{ inputs, pkgs, systemSettings, userSettings, ... }: {
  imports = [
    ../../home/system
    ../../home/programs
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
    swayosd
    playerctl
    pywal
    bluez
    bluez-tools
    hyprshot
    jq
    libnotify
    slurp
    wl-clipboard

    # terminal stuff
    foot
    starship
    wezterm
 
    # programs
    vesktop # Modded discord client
    waypaper # wallpaper utility
    swww # wallpaper backend 
    obsidian # note app
    inputs.zen-browser.packages."${system}".twilight # browser
    superfile # file explorer
    libreoffice-qt

    # Utils
    htop # process viewer
    networkmanagerapplet # networkmanager util
    git
    unzip
    wget
    speedtest-cli # speedtest.net cli
    zoxide
    fzf

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
    burpsuite

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
    code-cursor
    ]);
  };
  

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic"; 
    size = 24;
  };

  programs.git = {
    enable = true;
    userName = "blob";
    userEmail = "101657201+blob5@users.noreply.github.com";
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
}
