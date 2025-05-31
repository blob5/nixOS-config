{ inputs, pkgs, systemSettings, userSettings, ... }: {
  imports = [
    ../../modules/desktop/fonts.nix
    ../../modules/desktop/stylix.nix
    ../../modules/programs/editors/vscode.nix
    ../../modules/programs/terminals/wezterm/wezterm.nix
    ../../modules/programs/terminals/kitty/kitty.nix
    ../../modules/programs/terminals/zsh/zsh.nix
    ../../modules/programs/spicetify/spicetify.nix
    ../../modules/desktop/rofi/rofi.nix
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

      # Terminal
      wezterm

      # Programs
      vesktop
      waypaper
      inputs.swww.packages."${system}".swww
      obsidian
      superfile
      libreoffice-qt
      inputs.zen-browser.packages."${system}".twilight
      kdePackages.dolphin
      qbittorrent
      vlc
      inputs.better-control.packages."${system}".better-control

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

      # Fun
      sl
      cowsay
      cmatrix
      hollywood
      aalib
      pipes
      asciiquarium-transparent

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
