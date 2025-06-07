{ config, pkgs, systemSettings, ... }:

let
  hostSettings = import ../../../hosts/${systemSettings.hostname}/settings.nix;
in
{

  programs.waybar.enable = true;

  # Symlinks for Waybar configuration files. These points to the nix store paths.
  # When you want ot work on the config, 
  # you can use the zsh alias `waybar-dev` to work on the config with hot reloading

  home.file.".config/waybar/config.jsonc".source =
    config.lib.file.mkOutOfStoreSymlink ./${hostSettings.compositor}-config.jsonc;

  home.file.".config/waybar/modules.jsonc".source =
    config.lib.file.mkOutOfStoreSymlink ./modules.jsonc;

  home.file.".config/waybar/style.css".source =
    config.lib.file.mkOutOfStoreSymlink ./style.css;
}
