{ ... }:


{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    download-buffer-size = 52428800; # 50 MiB
    auto-optimise-store = true;
  };

  # Avoid freezing the system under memory pressure
  services.earlyoom.enable = true;
  services.earlyoom.enableNotifications = true; # Possible DoS vector if untrusted users on same pc.

  zramSwap = {
    enable = true;
    algorithm = "lz4";
  };


  nixpkgs.config = {
    allowUnfree = true;
    cudaSupport = true;
  };

  # Garbage collection
	nix.gc = {
		automatic = true;
		persistent = false;
		dates = "daily";
		options = "--delete-older-than 7d";
	};

  # Substututers
  nix.settings = {
		substituters = [
			"https://cache.nixos.org"
		];
    extra-substituters =  [
      "https://cache.flox.dev"
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org"
    ];
		trusted-public-keys = [
			"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
		];
    extra-trusted-public-keys = [
      "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
			"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
	};
}