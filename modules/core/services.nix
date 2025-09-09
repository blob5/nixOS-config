{ pkgs, lib, ... }:

{
  services = {
    tailscale.enable = true;

    resolved.enable = true;

    openssh.enable = true;

    upower.enable = true; # needed for hyprpanel

    pcscd.enable = true; # needed for gpg

    printing.enable = true;

    power-profiles-daemon.enable = true;

    dbus.enable = true;

    sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };
  };

  virtualisation.docker.enable = true;

  # Prevent Docker service from starting at boot
  systemd.services.docker.wantedBy = lib.mkForce [ ]; # disables autostart

  # Allow the docker socket to trigger it on demand
  systemd.sockets.docker.wantedBy = [ "sockets.target" ];


  # COnfigure keymap
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}