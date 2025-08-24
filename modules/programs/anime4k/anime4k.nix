{ ... }:

{
  home.file.".config/mpv/mpv.conf".source = ./mpv.conf;
  home.file.".config/mpv/input.conf".source = ./input.conf;

  xdg.configFile."mpv/shaders" = {
    source = ./shaders;
    recursive = true;
  };

}
