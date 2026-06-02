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

  # No wrapper needed – we’ll point to the custom mpv via mpv_ext_path.
  # (keep your other wrappers like lobster-wrapped if you use them)
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
    ani-cli
  ];

  services.jellyfin-mpv-shim = {
    enable  = true;
    package = pkgs.jellyfin-mpv-shim;   # use the original, un‑wrapped package
    settings = {
      always_transcode    = false;
      direct_paths        = true;
      remote_direct_paths = true;
      local_kbps          = 2147483;
      remote_kbps         = 1000000;

      # External MPV configuration
      mpv_ext         = true;
      mpv_ext_start   = true;
      mpv_ext_ipc     = "/tmp/jellyfin-mpv-shim.sock";
      mpv_ext_path    = "${mpv-with-vapoursynth}/bin/mpv";
      
      thumbnail_osc_builtin = false;

    };
  };
}
