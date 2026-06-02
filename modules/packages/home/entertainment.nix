{ inputs, pkgs, ... }:
let
  mpv-unwrapped-with-vapoursynth = pkgs.mpv-unwrapped.override {
    vapoursynthSupport = true;
    alsaSupport        = true;
    pulseSupport       = true;
    pipewireSupport    = true;
  };

  mpv-with-vapoursynth = pkgs.mpv.override {
    mpv-unwrapped = mpv-unwrapped-with-vapoursynth;
    scripts = with pkgs.mpvScripts; [
      uosc
      mpris
    ];
  };

  jellyfin-mpv-shim-vs = pkgs.symlinkJoin {
    name = "jellyfin-mpv-shim";
    paths = [ pkgs.jellyfin-mpv-shim ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/jellyfin-mpv-shim \
        --prefix PATH : "${mpv-with-vapoursynth}/bin"
    '';
  };

  lobster-wrapped = pkgs.symlinkJoin {
    name = "lobster-with-vapoursynth-mpv";
    paths = [ inputs.lobster.packages."${pkgs.system}".default ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      rm -f $out/bin/lobster
      if [ -e ${inputs.lobster.packages."${pkgs.system}".default}/bin/.lobster-wrapped ]; then
        cp ${inputs.lobster.packages."${pkgs.system}".default}/bin/.lobster-wrapped $out/bin/lobster
      else
        cp ${inputs.lobster.packages."${pkgs.system}".default}/bin/lobster $out/bin/lobster
      fi
      chmod +x $out/bin/lobster
      wrapProgram $out/bin/lobster \
        --prefix PATH : "${mpv-with-vapoursynth}/bin"
    '';
  };
in
{
  home.packages = with pkgs; [
    mpv-with-vapoursynth
    lobster-wrapped
    ffmpeg
    vapoursynth
    vapoursynth-mvtools
    vapoursynth-bestsource
    chafa
    ani-skip
    feh
    ani-cli
  ];

  services.jellyfin-mpv-shim = {
    enable  = true;
    package = jellyfin-mpv-shim-vs;
    settings = {
      always_transcode    = false;
      direct_paths        = true;
      remote_direct_paths = true;
      local_kbps          = 2147483;
      remote_kbps         = 1000000;
      mpv_ext             = true;
      mpv_ext_ipc         = "/tmp/jellyfin-mpv-shim.sock";
      mpv_ext_start       = true;
      mpv_ext_package     = mpv-with-vapoursynth;
    };
  };
}