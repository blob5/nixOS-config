{
  config,
  pkgs,
  userSettings,
  ...
}:

{
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = userSettings.username;
    dataDir = userSettings.homeDirectory;
  };
}
