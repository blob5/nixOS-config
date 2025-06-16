{ config, pkgs, ... }:

{

	imports = [
		../../modules/core/bluetooth.nix
		../../modules/core/networking.nix
		../../modules/core/boot.nix
		../../modules/core/locale.nix
		../../modules/core/users.nix

		../../modules/programs/editors/lazyvim.nix

		];

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

	systemd.user.units.swaync.enable = true;


	nix.settings.auto-optimise-store = true;
	nix.gc = {
		automatic = true;
		persistent = false;
		dates = "daily";
		options = "--delete-older-than 7d";
	};
	services.dbus.enable = true;


}
