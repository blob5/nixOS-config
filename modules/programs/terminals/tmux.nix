{ ... }:

{
  programs.tmux = {
    enable = true;
    mouse = true;
    historyLimit = 50000;
    terminal = "screen-256color";
  };
}