{ config, pkgs, ... }:

{

  programs.waybar.enable = true;

  # Symlinks for Waybar configuration files. These points to the nix store paths.
  # When you want ot work on the config, 
  # you can use the zsh alias `waybar-dev` to work on the config with hot reloading

  home.file.".config/waybar/config.jsonc".source =
    config.lib.file.mkOutOfStoreSymlink ./config.jsonc;

  home.file.".config/waybar/style.css".source =
    config.lib.file.mkOutOfStoreSymlink ./style.css;
  
}
