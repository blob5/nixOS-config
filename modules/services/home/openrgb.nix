{ pkgs, ... }:
{
  services.udev.packages = [ pkgs.openrgb-with-all-plugins ];
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];

  systemd.user.services.openrgb = {
    description = "OpenRGB with profile";
    after = [ "graphical-session.target" "network.target" ];
    wants = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.openrgb-with-all-plugins}/bin/openrgb --profile gaming --startminimized";
      Restart = "on-failure";
      RestartSec = 5;
    };

    wantedBy = [ "graphical-session.target" ];
  };
}