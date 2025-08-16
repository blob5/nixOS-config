# modules/programs/viu/viu.nix
{ ... }: 

{
  home.file.".config/viu/config.ini".source = ./config.ini;
}