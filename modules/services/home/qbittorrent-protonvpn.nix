{
  config,
  pkgs,
  ...
}:

let
  qbittorrentProfile = "${config.xdg.configHome}/qBittorrent";
in
{
  home.packages = with pkgs; [
    proton-vpn-cli
    qbittorrent-nox
  ];

  systemd.user.services.qbittorrent = {
    Unit = {
      Description = "qBittorrent (headless)";
      After = [ "network.target" ];
    };

    Service = {
      ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox --profile=${qbittorrentProfile} --webui-port=8080 --torrenting-port=6881";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  systemd.user.services.protonvpn = {
    Unit = {
      Description = "ProtonVPN connection";
      After = [ "network.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.proton-vpn-cli}/bin/protonvpn-cli connect --fastest";
      ExecStop = "${pkgs.proton-vpn-cli}/bin/protonvpn-cli disconnect";
      RemainAfterExit = true;
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
