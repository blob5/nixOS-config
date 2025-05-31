{ pkgs, systemSettings, ... }:

let
  hostSettings = import ../../hosts/${systemSettings.hostname}/settings.nix;
in
{
  networking.hostName = "${hostSettings.hostname}";
  networking.networkmanager.enable = true;
  networking.wireguard.enable = true;
  networking.firewall.enable = true;
  networking.nat.enable = true;


  # Auto-connect to Tailscale on boot
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