{ inputs, pkgs, ... }:

let
  # First create mpv-unwrapped with vapoursynth AND audio support
  mpv-unwrapped-with-vapoursynth = pkgs.mpv-unwrapped.override {
    vapoursynthSupport = true;
    # Add audio backend support
    alsaSupport = true;
    pulseSupport = true;
    pipewireSupport = true;
  };

  # Then build mpv with that unwrapped version and scripts
  mpv-with-vapoursynth = pkgs.mpv.override {
    mpv-unwrapped = mpv-unwrapped-with-vapoursynth;
    scripts = with pkgs.mpvScripts; [
      uosc # Modern UI
      mpris # Media player remote interface
    ];
  };

  # Wrap lobster to use our VapourSynth-enabled mpv
  lobster-wrapped = pkgs.symlinkJoin {
    name = "lobster-with-vapoursynth-mpv";
    paths = [ inputs.lobster.packages."${pkgs.system}".default ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      # Remove the original lobster wrapper to avoid double wrapping
      rm -f $out/bin/lobster
      # Copy the actual lobster Python script
      if [ -e ${inputs.lobster.packages."${pkgs.system}".default}/bin/.lobster-wrapped ]; then
        cp ${inputs.lobster.packages."${pkgs.system}".default}/bin/.lobster-wrapped $out/bin/lobster
      else
        cp ${inputs.lobster.packages."${pkgs.system}".default}/bin/lobster $out/bin/lobster
      fi
      chmod +x $out/bin/lobster

      # Wrap lobster to prepend our VapourSynth mpv to PATH
      wrapProgram $out/bin/lobster \
        --prefix PATH : "${mpv-with-vapoursynth}/bin"
    '';
  };
in
{
  home.packages = with pkgs; [
    # Media Entertainment
    lobster-wrapped # Movie streaming with VapourSynth interpolation support
    mpv-with-vapoursynth # Media player with VapourSynth for frame interpolation
    ffmpeg # Video/audio processing

    # VapourSynth: Frame processing framework for video filters
    vapoursynth # Core VapourSynth library
    vapoursynth-mvtools # Motion estimation plugin for interpolation
    vapoursynth-bestsource # Video source plugin

    chafa
    ani-skip
    feh
  ];
}
