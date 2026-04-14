{ lib, hostSettings, ... }:

let
  servicesCfg = hostSettings.services or { };
  dockerCfg = servicesCfg.docker or { };
  role = hostSettings.role or "desktop";
  isGraphical = role != "server";
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

    seatd.enable = isGraphical;

    upower.enable = isGraphical; # for battery status and power management

    pcscd.enable = true; # needed for gpg

    printing.enable = isGraphical;

    power-profiles-daemon.enable = isGraphical;

    dbus.enable = true;

    udisks2.enable = isGraphical;

    gnome.gnome-keyring.enable = isGraphical;

    xserver.enable = isGraphical;

    gvfs.enable = isGraphical; # for virtual filesystem support "trash, network shares, etc."

  };

  virtualisation.docker.enable = dockerCfg.enable or false;

  # Prevent Docker service from starting at boot
  systemd.services.docker.wantedBy = lib.mkForce [ ]; # disables autostart

  # Allow the docker socket to trigger it on demand
  systemd.sockets.docker.wantedBy = [ "sockets.target" ];

  # Configure keymap for graphical hosts
  services.xserver.xkb = lib.mkIf isGraphical {
    layout = "us";
    variant = "";
  };
}
