{ inputs, pkgs, systemSettings, userSettings, ... }: {
  imports = [
    ../../home/system
    ../../home/programs
    ../common/common-home.nix
  ];

  home = {
    username = userSettings.username;
    homeDirectory = "/home/"+userSettings.username;
    stateVersion = systemSettings.version;
  };

  # Host-specific git settings
  programs.git = {
    enable = true;
    userName = "blob";
  };
}
