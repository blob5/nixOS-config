{ pkgs, ... }:

{
  home.packages = with pkgs; [
    proton-vpn-cli
  ];

  systemd.user.services.protonvpn = {
    Unit = {
      Description = "ProtonVPN connection";
      After = [ "network-online.target" "dbus.service" ];
      Wants = [ "network-online.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.proton-vpn-cli}/bin/protonvpn connect";
      ExecStop = "${pkgs.proton-vpn-cli}/bin/protonvpn disconnect";
      RemainAfterExit = true;
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
