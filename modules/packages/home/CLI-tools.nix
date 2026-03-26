{ pkgs,hostSettings, ... }: {

  home = {
    packages = with pkgs; [

    # CLI tools
      btop
      aria2
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
      spotdl
      duf # Disk usage utility
      lazydocker
      ripgrep # better grep
      micro
      fd # better find
      zellij
      lazygit
      bat
      bat-extras.core
      glib 
    ];
  };
  # Nix search for CLI
  programs.nh = {
    enable = true;
    flake = "${hostSettings.flakeRoot}";
  };
}
