{
  system = "x86_64-linux";
  hostname = "navi";
  timezone = "Europe/Amsterdam";
  locale = "en_US.UTF-8";
  version = "24.11";
  fileSystemCreationDate = "24 March 18:17:35 2025";
  compositor = "hyprland";
  gpgkey = "77EC7100CA8F93A1";
  cudaSupport = false;

  # This is mostly used to reference the location of the source files outside of the Nix store
  # For example, the waybar-dev alias in zsh.nix configuration files
  flakeRoot = "$HOME/.config/nixos";

  bootloader = {
    efiSupport = true;
    device = "nodev";
  };
}
