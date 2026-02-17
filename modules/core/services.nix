{ pkgs, lib, systemSettings, ... }:

let
  hostSettings = import ../../hosts/${systemSettings.hostname}/settings.nix;
  servicesCfg = hostSettings.services or {};
  dockerCfg = servicesCfg.docker or {};
in

{
  services = {

    resolved.enable = true;

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
    };

    seatd.enable = true;

    upower.enable = true; # needed for hyprpanel

    pcscd.enable = true; # needed for gpg

    printing.enable = true;

    power-profiles-daemon.enable = true;

    dbus.enable = true;

    udisks2.enable = true;

    gnome.gnome-keyring.enable = true;

    xserver.enable = true;

  };

  virtualisation.docker.enable = dockerCfg.enable or false;

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