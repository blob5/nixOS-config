# modules/programs/mako/mako.nix
{ ... }:

{
  services.mako.enable = true;
  home.file.".config/mako/config".source = ./config;
}