{ pkgs, ... }:

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
      autoStart = false;
      capSysAdmin = true;
      openFirewall = true;
    };
  };

  virtualisation.docker.enable = true;


  # COnfigure keymap
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}