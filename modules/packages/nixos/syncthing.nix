{ config, pkgs, ... }:

{
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "blob";
    dataDir = "/home/blob";
  };
}
