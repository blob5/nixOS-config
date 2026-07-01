{ hostSettings, pkgs, ... }:
let
  role = hostSettings.role or "desktop";
  isGraphical = role != "server";
in
{

  environment.systemPackages = with pkgs; [

    # System Services
    gnome-bluetooth
    awww
    brightnessctl
    bluez
    bluez-tools
    lm_sensors
    iw
    home-manager
    ddcutil # for controlling monitor settings
  ];

  services.envfs.enable = true;
  services.fstrim.enable = true;
  services.fwupd.enable = true;
  programs.nix-ld.enable = true;
  programs.zsh.enable = true;
  programs.gpu-screen-recorder.enable = isGraphical;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # waylock PAM configuration
  security.pam.services = {
    login.enableGnomeKeyring = true;
    waylock = {
      text = ''
        auth      include login
        account   include login
        password  include login
        session   include login
      '';
    };
  };
}
