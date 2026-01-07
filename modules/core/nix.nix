{
  systemSettings,
  ...
}:

let
  hostSettings = import ../../hosts/${systemSettings.hostname}/settings.nix;
in
{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    download-buffer-size = 52428800; # 50 MiB
    auto-optimise-store = true;
    substituters = [
        "https://cache.nixos.org"
        "https://cache.flox.dev"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
        "https://attic.xuyh0120.win/lantian" # nix-cachyos-kernel
        "https://cache.garnix.io"
      ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };

  # Avoid freezing the system under memory pressure
  services.earlyoom.enable = true;
  services.earlyoom.enableNotifications = true; # Possible DoS vector if untrusted users on same pc.

  zramSwap = {
    enable = false;
    algorithm = "lz4";
  };


  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = hostSettings.cudaSupport;
  };

  # Garbage collection
	nix.gc = {
		automatic = true;
		persistent = false;
		dates = "daily";
		options = "--delete-older-than 7d";
	};
}