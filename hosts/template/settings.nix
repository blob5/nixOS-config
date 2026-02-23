{
  system = "x86_64-linux";
  hostname = "template";
  username = "template";
  timezone = "Europe/Amsterdam";
  locale = "en_US.UTF-8";
  version = "25.11";
  compositor = ""; # e.g. "hyprland" or "niri"
  gpgkey = "CHANGE_ME";
  cudaSupport = false;
  cpuVendor = "CHANGE_ME"; # e.g. "amd" or "intel"

  services = {
    docker.enable = false;
  };

  user = {
    username = "CHANGE_ME";
    name = "CHANGE_ME";
    homeDirectory = "/home/CHANGE_ME";
    dotfilesDir = "~/.config/nixos";
    extraGroups = [ "networkmanager" "wheel" "docker" "wireshark" "syncthing" "libvirt" "kvm" "input" "i2c" "dialout" ];
    sshAuthorizedKeys = [
      "ssh-ed25519 CHANGE_ME"
    ];
  };

  # This is mostly used to reference the location of the source files outside of the Nix store
  # For example, the waybar-dev alias in zsh.nix configuration files
  flakeRoot = "$HOME/.config/nixos";

  bootloader = {
    efiSupport = true;
    device = "nodev";
  };

  ### Used for grub theme, can be obtained by running the following command in the terminal:
  # DEVICE=$(df / | awk 'NR==2 {print $1}')
  # sudo tune2fs -l "$DEVICE" | grep 'Filesystem created:'
  ###
  fileSystemCreationDate = "CHANGE_ME";

}
