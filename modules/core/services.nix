{ pkgs, lib, ... }:

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

    upower.enable = true; # needed for hyprpanel

    pcscd.enable = true; # needed for gpg

    printing.enable = true;

    power-profiles-daemon.enable = true;

    dbus.enable = true;

    udisks2.enable = true;

    gnome.gnome-keyring.enable = true;


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