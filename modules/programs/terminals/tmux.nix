{ pkgs, ... }:

{
  programs.tmux = {
    mouse = true;
    focusEvents = true;
    aggressiveResize = true;
    clock24 = true;
    historyLimit = 50000;
    enable = true;
    escapeTime = 0;
    terminal = "screen-256color";

    
    plugins = [
      pkgs.tmuxPlugins.sensible
      pkgs.tmuxPlugins.tokyo-night-tmux
    ];
  };
}