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
      git
      python312
      nodejs
      nixfmt-rfc-style



      # Terminals
      wezterm
      ghostty

      # CLI tools
      htop
      wget
      ookla-speedtest
      zoxide
      fzf
      eza
      tree
      jq
      ncdu
      entr
      superfile
      fastfetch

      # Media & Applications
      inputs.zen-browser.packages."${system}".twilight
      kdePackages.dolphin # File manager
      kdePackages.ark # Archive manager
      kdePackages.gwenview # Image viewer
      qbittorrent
      vlc
      foliate # E reader
      libreoffice-qt
      superfile
      obsidian
      zed-editor

      
      # Media
      inputs.lobster.packages."${system}".lobster
      inputs.fastanime.packages."${system}".default
      ffmpeg
      (mpv.override { scripts = [
        mpvScripts.uosc
        mpvScripts.thumbfast
        mpvScripts.mpris
      ]; })
      chafa
      ani-skip
      feh

      # Archive tools
      p7zip
      unzip
      zip
      xz

      # Security & Pentesting tools
      nmap
      traceroute
      whois
      dig
      metasploit
      john
      hashcat
      gobuster
      burpsuite
      wireshark-qt
      bettercap
      asn
      aircrack-ng

      # Fun
      sl
      cowsay
      cmatrix
      hollywood
      aalib
      pipes
      asciiquarium-transparent
      cava


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
