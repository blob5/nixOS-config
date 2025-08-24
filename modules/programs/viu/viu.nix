# modules/programs/viu/viu.nix
{ ... }: 

{
  home.file.".config/viu/config.toml".source = ./config.toml;
}