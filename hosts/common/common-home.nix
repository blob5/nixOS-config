{ inputs, pkgs, systemSettings, userSettings, ... }: {
  imports = [
    ../../modules/desktop/fonts.nix
    ../../modules/desktop/stylix/stylix.nix
    ../../modules/programs/editors/vscode.nix
    ../../modules/programs/terminals/wezterm/wezterm.nix
    ../../modules/programs/terminals/kitty/kitty.nix
    ../../modules/programs/terminals/zsh/zsh.nix
    ../../modules/programs/spicetify/spicetify.nix
    ../../modules/desktop/rofi/rofi.nix
    ../../modules/programs/nixcord.nix
    ../../modules/desktop/waybar/waybar.nix
  ];

  home = {
    packages = with pkgs; [
      # Development
      openjdk
      python312

      # System
      killall
      gnome-bluetooth
      playerctl
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
      pavucontrol
      ncdu
      blueman
      dconf
      entr # file watcher
      lm_sensors
      pulseaudio
      (mpv.override { scripts = [
        mpvScripts.uosc
        mpvScripts.thumbfast
        mpvScripts.mpris
      ]; })
      
      # Terminal
      wezterm

      # Programs
      waypaper
      swww
      obsidian
      superfile
      libreoffice-qt
      inputs.zen-browser.packages."${system}".twilight
      kdePackages.dolphin
      qbittorrent
      vlc
      better-control
      kdePackages.gwenview
      foliate

      # lobster
      inputs.lobster.packages."${system}".lobster

      # fastanime
      inputs.fastanime.packages."${system}".default
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
      asn

      # Fun
      sl
      cowsay
      cmatrix
      hollywood
      aalib
      pipes
      asciiquarium-transparent
      cava

      # Editors
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
