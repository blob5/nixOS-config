{
  system = "x86_64-linux";
  hostname = "navi";
  username = "blob";
  timezone = "Europe/Amsterdam";
  locale = "en_US.UTF-8";
  version = "24.11";
  fileSystemCreationDate = "24 March 18:17:35 2025";
  compositor = "hyprland";
  gpgkey = "77EC7100CA8F93A1";
  cudaSupport = false;
  cpuVendor = "amd";

  services = {
    docker.enable = true;
  };

  user = {
    username = "blob";
    name = "blob";
    homeDirectory = "/home/blob";
    dotfilesDir = "~/.config/nixos";
    extraGroups = [ "networkmanager" "wheel" "docker" "wireshark" "syncthing" "libvirt" "kvm" "input" "i2c" "dialout" ];
    sshAuthorizedKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMsCampY/bxZa3GuirZUoQf7PhvnaWZOsekcBLaGTWps 101657201+blob5@users.noreply.github.com"
    ];
  };

  # This is mostly used to reference the location of the source files outside of the Nix store
  # For example, the waybar-dev alias in zsh.nix configuration files
  flakeRoot = "$HOME/.config/nixos";

  bootloader = {
    efiSupport = true;
    device = "nodev";
  };
}
