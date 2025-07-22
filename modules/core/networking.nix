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

  # Speeds up boot times by not waiting to be online
  # Probably not smart to have this on for servers or machines with remote mounts.
  systemd.services.NetworkManager-wait-online.enable = false;

  # Auto-connect to Tailscale on boot
  systemd.services.tailscale-autoconnect = {
    description = "Auto-connect to Tailscale after login";
    after = [
      "network-online.target"
      "tailscaled.service"
      "sddm.service"
    ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.tailscale}/bin/tailscale up";
    };
  };
}
