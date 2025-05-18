{ config, pkgs, ... }:

{
	nix.settings.auto-optimise-store = true;
	nix.gc.automatic = true;
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
