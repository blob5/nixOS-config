{ pkgs, ... }:
{
  services.udev.packages = [ pkgs.openrgb-with-all-plugins ];
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];

  systemd.user.services.openrgb = {
    description = "OpenRGB with profile";
    after = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.openrgb-with-all-plugins}/bin/openrgb --profile gaming --startminimized";
      
      Environment = [
        "DISPLAY=:0"
        "WAYLAND_DISPLAY=wayland-0"
      ];

      Restart = "on-failure";
      RestartSec = 5;
    };

    wantedBy = [ "default.target" ];
  };
}