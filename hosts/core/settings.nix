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
