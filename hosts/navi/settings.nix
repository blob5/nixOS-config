{
  system = "x86_64-linux";
  hostname = "navi";
  timezone = "Europe/Amsterdam";
  locale = "en_US.UTF-8";
  version = "25.11";
  hasNvidia = true;
  fileSystemCreationDate = "24 March 18:17:35 2025";
  compositor = "hyprland";

  # This is mostly used to reference the location of the source files outside of the Nix store
  # For example, the waybar-dev alias in zsh.nix configuration files
  flakeRoot = "$HOME/.config/nixos";

  bootloader = {
    efiSupport = false;
    device = "/dev/nvme0n1";
  };
}
