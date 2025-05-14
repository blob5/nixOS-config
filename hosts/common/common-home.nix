{ inputs, pkgs, systemSettings, userSettings, ... }: {
  imports = [
    ../../home/programs
    ../../home/system
  ];

  home = {
    packages = with pkgs; [
      # Development
      openjdk
      python312

      # System
      papirus-icon-theme
      killall
      gnome-bluetooth
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
      wireguard-tools
      file
      brightnessctl
      ncdu

      # Terminal
      foot
      starship
      wezterm

      # Programs
      vesktop
      waypaper
      swww
      obsidian
      superfile
      libreoffice-qt
      signal-desktop-bin
      inputs.zen-browser.packages."${system}".twilight
      kdePackages.dolphin
      qbittorrent
      vlc
      protonup-qt
      inputs.better-control.packages."${system}".better-control

      # lobster
      inputs.lobster.packages."${system}".lobster

      # fastanime
      inputs.fastanime.packages."${system}".default
      mpv
      mpvScripts.uosc
      mpvScripts.thumbfast
      ffmpeg
      chafa
      ani-skip
      feh

      # Utils
      htop
      networkmanagerapplet
      git
      wget
      ookla-speedtest
      zoxide # replacement for cd
      fzf # fuzzy finder
      eza # replacement for ls

      # extracting tools
      p7zip
      unzip
      zip
      xz

      # Cyber Security
      nmap
      traceroute
      whois
      dig
      metasploit
      iw
      aircrack-ng
      inetutils
      john
      hashcat
      gobuster
      burpsuite
      wireshark-qt
      bettercap

      # Fun
      sl
      cowsay
      cmatrix
      hollywood
      aalib
      pipes
      asciiquarium-transparent

      # Editors
      vim
      vscode
      neovide
      neovim
      code-cursor
    ];

    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };
  };

  programs.git = {
    enable = true;
    userEmail = "101657201+blob5@users.noreply.github.com";
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
}
