{ config, pkgs, ... }:

let
  frappeTheme = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/kitty/main/themes/frappe.conf";
    sha256 = "sha256-qRiyPWo1Mq7YRc8esaf+aYnTqzxthHVvNp97CPGbxZg=";
  };
in
{
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font";
      size = 12.0;
    };
    extraConfig = builtins.readFile ./kitty.conf;
  };

  home.file.".config/kitty/catppuccin-frappe.conf".source = frappeTheme;
}
