{ config, pkgs, lib, ... }:

{
  # Enable pywal and generate the colorscheme
  programs.pywal = {
    enable = true;
    generate = true;
  };

  # Enable swww for wallpaper management
  programs.swww = {
    enable = true;
    wallpaper = "~/.config/nixos/wall/Kurumi-Ebisuzawa.png";  # Set your wallpaper path here
  };

  # Configure the pywal color template for Hypr
  home.file = {
    ".config/hypr/colors.json" = {
      source = "${config.programs.pywal.cacheDir}/colors.json";  # Link to pywal generated colors
    };

    # Place the discord-pywal.css template in the correct location
    ".config/wal/templates/discord-pywal.css" = {
      source = ./templates/discord-pywal.css;  # Adjust the path to the template file
    };
  };

  # Automatically generate the pywal palette, apply it, and copy the theme for Vencord
  home.activation = lib.mkAfter ''
    # Generate the pywal palette and apply it
    wal -i ${config.programs.swww.wallpaper}
    
    # Assuming Vencord stores themes in ~/.config/Vencord/themes/
    cp ~/.cache/wal/discord-pywal.css ~/.config/vesktop/themes/pywal.css
  '';
}
