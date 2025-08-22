{ pkgs, ... }: {

  home = {
    packages = with pkgs; [

    # CLI tools
      htop
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
      ripgrep
      micro
    ];
  };
}
