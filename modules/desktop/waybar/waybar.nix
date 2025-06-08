{ config, pkgs, systemSettings, ... }:

let
  hostSettings = import ../../../hosts/${systemSettings.hostname}/settings.nix;
in
{

  programs.waybar.enable = true;

  # Symlinks for Waybar configuration files. These points to the nix store paths.
  # When you want ot work on the config, 
  # you can use the zsh alias `waybar-dev` to work on the config with hot reloading

  home.file.".config/waybar/modules.jsonc".source = ./${hostSettings.compositor}-modules.jsonc;

  # Silly workaround to make waybar work with multple files
  # I don't put the inlcude inside the files themselves beacuse otherwise the waybar-dev
  # alias would not work properly
  programs.waybar = {
    settings = {
      mainBar = {
        include = [ "$HOME/.config/waybar/modules.jsonc" "$HOME/.config/waybar/config.jsonc" ];
      };
    };
  };
  home.file.".config/waybar/config.jsonc".source = ./config.jsonc;

  home.file.".config/waybar/style.css".source = ./style.css;
}
