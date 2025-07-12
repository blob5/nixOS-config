{ pkgs, ... }: {

  home = {
    packages = with pkgs; [

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
      spotdl
      duf # Disk usage utility
      lazydocker
      ripgrep
    ];
  };
}
