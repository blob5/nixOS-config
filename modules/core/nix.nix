{ ... }:


{

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.download-buffer-size = 524288000; # 500 MiB
  nixpkgs.config = {
    allowUnfree = true;
  };

  # Garbage collection
	nix.settings.auto-optimise-store = true;
	nix.gc = {
		automatic = true;
		persistent = false;
		dates = "daily";
		options = "--delete-older-than 7d";
	};

  # Substututers
  nix.settings = {
		substituters = [
			"https://cache.nixos.org?priority=10"
			"https://hyprland.cachix.org"
			"https://nix-community.cachix.org"
		];
		trusted-public-keys = [
			"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
			"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
		];
	};
}