{ pkgs, ... }: {
  # ----- Existing mpv config (kept as is) -----
  home.file.".config/mpv/mpv.conf".source = ./mpv.conf;
  home.file.".config/mpv/input.conf".source = ./input.conf;
  home.file.".config/mpv/interpolation.vpy".source = ./interpolation.vpy;

  xdg.configFile."mpv/shaders" = {
    source = ./shaders;
    recursive = true;
  };

  # VapourSynth plugins (unchanged)
  home.file.".local/lib/vapoursynth/libmvtools.so".source =
    "${pkgs.vapoursynth-mvtools}/lib/vapoursynth/libmvtools.so";
  home.file.".local/lib/vapoursynth/bestsource.so".source =
    "${pkgs.vapoursynth-bestsource}/lib/vapoursynth/bestsource.so";

  xdg.configFile."vapoursynth/vapoursynth.conf".text = ''
    AutoloadSystemPluginDir=true
    SystemPluginDir=${pkgs.vapoursynth-mvtools}/lib/vapoursynth:${pkgs.vapoursynth-bestsource}/lib/vapoursynth
  '';

  # ----- NEW: duplicate the same files for jellyfin-mpv-shim -----
  home.file.".config/jellyfin-mpv-shim/mpv.conf".source = ./mpv.conf;
  home.file.".config/jellyfin-mpv-shim/input.conf".source = ./input.conf;
  home.file.".config/jellyfin-mpv-shim/interpolation.vpy".source = ./interpolation.vpy;

  xdg.configFile."jellyfin-mpv-shim/shaders" = {
    source = ./shaders;
    recursive = true;
  };
}
