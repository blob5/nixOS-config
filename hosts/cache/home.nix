{
  config,
  inputs,
  pkgs,
  userSettings,
  ...
}:

{
  imports = [
    ../common/home/desktop.nix

    # Programs
    ../../modules/programs/terminals/wezterm/wezterm.nix

    # Desktop
    ../../modules/desktop/compositors/niri/niri.nix

  ];

  home = {
    packages = with pkgs; [
      # Quickshell Noctalia configuration
      inputs.noctalia.packages.${pkgs.system}.default

      # Media & Applications
      nautilus # File manager
      kdePackages.ark # Archive manager
      kdePackages.gwenview # Image viewer
      vlc
      obsidian
    ];
  };

  niri = {
    monitors = [ "eDP-1,1920x1080@60,0x0,1" ];
    input.sensitivity = 0.5;
    input.kb_layout = "us";
  };

  # Host-specific home-manager settings
  home.username = userSettings.username;
  home.homeDirectory = userSettings.homeDirectory;
  home.stateVersion = "25.11"; # Match your NixOS version
}
