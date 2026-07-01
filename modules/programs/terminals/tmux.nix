{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    plugins = [
      pkgs.tmuxPlugins.sensible
      pkgs.tmuxPlugins.tokyo-night-tmux
    ];
  };
}