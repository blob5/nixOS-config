{
  system = "x86_64-linux";
  hostname = "core";
  timezone = "Europe/Amsterdam";
  locale = "en_US.UTF-8";
  version = "25.11";
  fileSystemCreationDate = "25 August 18:10:04 2025";
  compositor = "";
  gpgkey = "F1C140E19A2300F1";
  cudaSupport = false;

  # This is mostly used to reference the location of the source files outside of the Nix store
  # For example, the waybar-dev alias in zsh.nix configuration files
  flakeRoot = "$HOME/.config/nixos";

  bootloader = {
    efiSupport = true;
    device = "nodev";
  };
}
