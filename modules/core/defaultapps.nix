
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
  };

}