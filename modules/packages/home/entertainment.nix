{ inputs, pkgs, ... }:

let
  # Custom mpv build with VapourSynth support for frame interpolation
  # This overrides mpv-unwrapped to enable vapoursynthSupport, then wraps it with scripts
  mpv-with-vapoursynth = pkgs.mpv.override {
    mpv = pkgs.mpv-unwrapped.override {
      vapoursynthSupport = true;  # Enable VapourSynth video filter support
    };
    scripts = with pkgs.mpvScripts; [
      uosc       # Modern UI
      thumbfast  # Fast thumbnails
      mpris      # Media player remote interface
    ];
  };

  # Wrap viu (anime streaming tool) to use our VapourSynth-enabled mpv
  # We must unwrap the original viu first, then rewrap it with our custom mpv at the front of PATH
  # This ensures viu uses our mpv instead of its bundled one (which lacks VapourSynth support)
  viu-wrapped = pkgs.symlinkJoin {
    name = "viu-with-vapoursynth-mpv";
    paths = [ inputs.viu.packages."${pkgs.system}".default ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      # Remove the original viu wrapper to avoid double wrapping
      rm $out/bin/viu
      # Copy the actual viu Python script
      cp ${inputs.viu.packages."${pkgs.system}".default}/bin/.viu-wrapped $out/bin/viu || \
        cp ${inputs.viu.packages."${pkgs.system}".default}/bin/viu $out/bin/viu
      chmod +x $out/bin/viu
      
      # Wrap viu to prepend our VapourSynth mpv to PATH (making it the first mpv found)
      wrapProgram $out/bin/viu \
        --prefix PATH : "${mpv-with-vapoursynth}/bin"
    '';
  };

  # Wrap viu (anime streaming tool) to use our VapourSynth-enabled mpv
  # We must unwrap the original viu first, then rewrap it with our custom mpv at the front of PATH
  # This ensures viu uses our mpv instead of its bundled one (which lacks VapourSynth support)
  lobster-wrapped = pkgs.symlinkJoin {
    name = "viu-with-vapoursynth-mpv";
    paths = [ inputs.lobster.packages."${pkgs.system}".default ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      # Remove the original viu wrapper to avoid double wrapping
      rm $out/bin/lobster
      # Copy the actual lobster Python script
      cp ${inputs.lobster.packages."${pkgs.system}".default}/bin/.lobster-wrapped $out/bin/lobster || \
        cp ${inputs.lobster.packages."${pkgs.system}".default}/bin/lobster $out/bin/lobster
      chmod +x $out/bin/lobster
      
      # Wrap lobster to prepend our VapourSynth mpv to PATH (making it the first mpv found)
      wrapProgram $out/bin/lobster \
        --prefix PATH : "${mpv-with-vapoursynth}/bin"
    '';
  };
in
{
  home.packages = with pkgs; [
    # Media Entertainment
    lobster-wrapped          # Movie streaming with VapourSynth interpolation support
    viu-wrapped              # Anime streaming with VapourSynth interpolation support
    mpv-with-vapoursynth     # Media player with VapourSynth for frame interpolation
    ffmpeg                   # Video/audio processing

    # VapourSynth: Frame processing framework for video filters
    vapoursynth              # Core VapourSynth library
    vapoursynth-mvtools      # Motion estimation plugin for interpolation
    vapoursynth-bestsource   # Video source plugin

    chafa
    ani-skip
    feh
  ];
}
