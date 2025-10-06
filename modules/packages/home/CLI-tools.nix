{ pkgs, ... }: {

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
    ];
  };
}
