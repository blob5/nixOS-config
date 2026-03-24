{ pkgs, hostSettings, ... }:

let
  patchedNetbird = pkgs.netbird.override {
    buildGoModule = pkgs.buildGo125Module;
  };
in
{
  warnings = [
    ''
      TEMPORARY PIN: netbird is pinned to buildGo125Module.
      Remove this override once netbird is compatible with the default Go version.
    ''
  ];
  networking.hostName = hostSettings.hostname;
  networking.networkmanager.enable = true;
  networking.wireguard.enable = true;
  networking.firewall.enable = true;
  networking.nat.enable = true;
  networking.nftables.enable = true;

  networking.firewall.checkReversePath = "loose"; # This is needed for libvirt guest-to-guest communication.
  # Speeds up boot times by not waiting to be online
  # Probably not smart to have this on for servers or machines with remote mounts.
  systemd.services.NetworkManager-wait-online.enable = false;

  services.netbird = {
    enable = true;
    package = patchedNetbird;
    ui.package = pkgs.netbird-ui.override {
      netbird = patchedNetbird;
    };
  };
}
