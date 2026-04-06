{
  enable = false; # Set to true to enable this host configuration, false to ignore it
  system = "x86_64-linux"; # e.g. "x86_64-linux" or "aarch64-linux"
  hostname = "template"; # The hostname of the machine, e.g. "my-laptop" or "my-desktop"
  timezone = "Europe/Amsterdam"; # The timezone of the machine, e.g. "Europe/Amsterdam" or "America/New_York"
  locale = "en_US.UTF-8"; # The locale of the machine, e.g. "en_US.UTF-8" or "de_DE.UTF-8"
  version = "25.11";
  compositor = ""; # e.g. "hyprland" or "niri"
  gpgkey = "CHANGE_ME"; # gpg key used for things like signing commits.
  cudaSupport = false; # Set to true if the machine has an NVIDIA GPU and you want to enable CUDA support
  cpuVendor = "CHANGE_ME"; # e.g. "amd" or "intel"

  services = {
    docker.enable = false;
  };

  user = {
    username = "CHANGE_ME"; # Primary username, e.g. "alice" or "bob"
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
