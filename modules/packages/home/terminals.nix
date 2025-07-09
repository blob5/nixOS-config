{ pkgs, ... }: {

  home = {
    packages = with pkgs; [
      
      # Terminals
      wezterm
      ghostty

    ];
  };
}