{ pkgs, ... }:

{
  home.file.".config/mpv/mpv.conf".source = ./mpv.conf;
  home.file.".config/mpv/input.conf".source = ./input.conf;

  xdg.configFile."mpv/shaders" = {
    source = ./shaders;
    recursive = true;
  };

  home.file.".config/mpv/interpolation.vpy".source = ./interpolation.vpy;

  # Create symlinks for VapourSynth plugins in the user's local directory
  # so VapourSynth can find them automatically
  home.file.".local/lib/vapoursynth/libmvtools.so".source = "${pkgs.vapoursynth-mvtools}/lib/vapoursynth/libmvtools.so";
  home.file.".local/lib/vapoursynth/bestsource.so".source = "${pkgs.vapoursynth-bestsource}/lib/vapoursynth/bestsource.so";

  # VapourSynth configuration to ensure plugins are found
  # The SystemPluginDir points directly to the nix store paths
  xdg.configFile."vapoursynth/vapoursynth.conf".text = ''
    AutoloadSystemPluginDir=true
    SystemPluginDir=${pkgs.vapoursynth-mvtools}/lib/vapoursynth:${pkgs.vapoursynth-bestsource}/lib/vapoursynth
  '';

}
