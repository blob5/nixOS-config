{ pkgs, ... }:

let
  jellyfinShimConfig = builtins.toJSON {
    always_transcode = false;
    transcode_hdr = false;
    transcode_dolby_vision = false;
    transcode_hi10p = false;
    transcode_hevc = false;
    transcode_av1 = false;
    transcode_4k = false;
    local_kbps = 2147483;
    remote_kbps = 10000;
  };
in
{
  home.packages = [ pkgs.jellyfin-mpv-shim ];

  xdg.configFile."jellyfin-mpv-shim/conf.json".text = jellyfinShimConfig;
}
