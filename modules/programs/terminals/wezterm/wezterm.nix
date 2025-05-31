# modules/programs/terminals/wezterm/wezterm.nix
{ config, lib, pkgs, ... }: {
  
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    extraConfig = builtins.readFile ./wezterm.lua;
  };
}
