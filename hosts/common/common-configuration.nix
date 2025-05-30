{ config, pkgs, ... }:

{

	imports = [
		../../modules/core/bluetooth.nix
		];

	nix.settings.auto-optimise-store = true;
	nix.gc = {
		automatic = true;
		persistent = false;
		dates = "daily";
		options = "--delete-older-than 7d";
	};
	services.dbus.enable = true;

	systemd.services.tailscale-autoconnect = {
		description = "Auto-connect to Tailscale";
		after = [ "network-online.target" "tailscaled.service" ];
		wants = [ "network-online.target" ];
		wantedBy = [ "multi-user.target" ];

		serviceConfig = {
			Type = "oneshot";
			ExecStart = ''
			${pkgs.tailscale}/bin/tailscale up
			'';
		};
		};
}
