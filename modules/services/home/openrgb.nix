{ pkgs, ... }:
{
  systemd.user.services.openrgb = {
  Unit = {
    Description = "OpenRGB with profile";
    After = [ "graphical-session.target" ];
  };
  Service = {
    Type = "simple";
    ExecStart = "${pkgs.openrgb}/bin/openrgb --profile gaming --startminimized";
    Restart = "on-failure";
    RestartSec = 5;
  };
  Install = {
    WantedBy = [ "default.target" ];
  };
};
}