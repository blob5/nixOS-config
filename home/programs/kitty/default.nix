{ config, pkgs, ... }:

let
  frappeTheme = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/kitty/main/themes/frappe.conf";
    sha256 = "sha256-boYuT8Ptiy1598hptuKX88lKOIbixOAwCvGX6ln92iQ=";
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
