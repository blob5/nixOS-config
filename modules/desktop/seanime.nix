{ pkgs, customMpv, ... }:

let
  seanime-open = pkgs.writeShellScriptBin "seanime-open" ''
    # function to decode url in parameter to be able to pass it to media player
    function urldecode() { : "''${*//+/ }"; echo -e "''${_//%/\\x}"; }

    if [[ "$1" == "seanime:"* ]]; then
        ref=''${1#seanime://stream?}
        url=$(urldecode "$ref")
        
        # see entertainment.nix for the custom mpv with vapoursynth support
        ${customMpv}/bin/mpv "''${url}"
    else
        ${pkgs.xdg-utils}/bin/xdg-open "$1"
    fi
  '';
in
{
  home.packages = [ seanime-open ];

  xdg.desktopEntries.seanime-open = {
    name = "seanime handler";
    comment = "Open seanime:// links with MPV.";
    exec = "${seanime-open}/bin/seanime-open %u";
    icon = "mpv";
    terminal = false;
    type = "Application";
    mimeType = [ "x-scheme-handler/seanime" ];
    settings = {
      NoDisplay = "true";
      TryExec = "${seanime-open}/bin/seanime-open";
    };
  };

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/seanime" = [ "seanime-open.desktop" ];
  };
}