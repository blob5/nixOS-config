{pkgs, ...}: 

{
  environment.systemPackages = with pkgs; [
      protonup-qt # managing Proton versions
      mangohud # Performance overlay add "mangohud %command%" to launch options
    ];

  programs = {
    gamemode.enable = true; # Add "gamemoderun %command%" to launch options to use gamemode
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      package = pkgs.steam.override {
        extraEnv = {
          GAMEMODERUN = "1";
        };
      };
    };
  };
}