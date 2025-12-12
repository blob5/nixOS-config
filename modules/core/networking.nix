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
  networking.nftables.enable = true;

  networking.firewall.checkReversePath = "loose"; # This is needed for libvirt guest-to-guest communication.
  # Speeds up boot times by not waiting to be online
  # Probably not smart to have this on for servers or machines with remote mounts.
  systemd.services.NetworkManager-wait-online.enable = false;

  services.netbird.enable = true;
}
