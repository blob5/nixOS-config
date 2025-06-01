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

	nix.settings.auto-optimise-store = true;
	nix.gc = {
		automatic = true;
		persistent = false;
		dates = "daily";
		options = "--delete-older-than 7d";
	};
	services.dbus.enable = true;


}
