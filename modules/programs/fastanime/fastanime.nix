# modules/programs/fastanime/fastanime.nix
{ ... }: 

{
  home.file.".config/fastanime/config.ini".source = ./config.ini;
}