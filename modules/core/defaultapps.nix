
{ ... }:

{
  xdg.mime.defaultApplications = {
    "inode/directory" = [ "org.gnome.Nautilus.desktop" ];

    # Common image MIME types
    "image/png" = [ "org.kde.gwenview.desktop" ];
    "image/jpeg" = [ "org.kde.gwenview.desktop" ];
    "image/jpg" = [ "org.kde.gwenview.desktop" ];
    "image/webp" = [ "org.kde.gwenview.desktop" ];
    "image/gif" = [ "org.kde.gwenview.desktop" ];
    "image/bmp" = [ "org.kde.gwenview.desktop" ];
    "image/tiff" = [ "org.kde.gwenview.desktop" ];

    # Text and code
    "text/plain" = [ "code.desktop" ];
    "text/x-python" = [ "code.desktop" ];
    "text/x-c" = [ "code.desktop" ];
    "text/x-c++src" = [ "code.desktop" ];
    "text/x-java" = [ "code.desktop" ];
    "text/x-shellscript" = [ "code.desktop" ];
    "text/x-ini" = [ "code.desktop" ];
    "text/x-toml" = [ "code.desktop" ];
    "application/json" = [ "code.desktop" ];
    "application/x-yaml" = [ "code.desktop" ];
    "application/xml" = [ "code.desktop" ];

    # PDF files → Zen Browser
    "application/pdf" = [ "zen-twilight.desktop" ];

    "x-scheme-handler/terminal" = [ "wezterm.desktop" ];
  };
}
