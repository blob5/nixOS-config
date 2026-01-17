{
  system = "x86_64-linux";
  hostname = "cyberia";
  timezone = "Europe/Amsterdam";
  locale = "en_US.UTF-8";
  version = "25.11";
  fileSystemCreationDate = "21 November 21:44:02 2024";
  compositor = "niri";
  gpgkey = "278803B57DAB54E6";
  cudaSupport = false;

  # This is mostly used to reference the location of the source files outside of the Nix store
  # For example, the waybar-dev alias in zsh.nix configuration files
  flakeRoot = "$HOME/.config/nixos";

  bootloader = {
    efiSupport = true;
    device = "nodev";
  };
}