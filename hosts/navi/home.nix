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
    userName = "blob5";
    signing = {
      key = "12E0BF53BFD81E3F";
      signByDefault = true;
    };
  };
}
