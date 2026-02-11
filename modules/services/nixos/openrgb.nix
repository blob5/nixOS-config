# modules/services/openrgb.nix
{ pkgs, ... }:

{
  # Required for i2c access by OpenRGB
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];
  services.udev.packages = [ pkgs.openrgb-with-all-plugins ];

  # Home manager user service
  home-manager.users.blob = {
    systemd.user.services.openrgb = {
      Unit = {
        Description = "OpenRGB with profile";
        After = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart =
          "${pkgs.openrgb-with-all-plugins}/bin/openrgb --profile gaming --startminimized";
        Restart = "on-failure";
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
