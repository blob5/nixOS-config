{pkgs, ...}: 

{
  environment.systemPackages = with pkgs; [
      protonup-qt # managing Proton versions
      mangohud # Performance overlay add "mangohud %command%" to launch options
      wineWowPackages.waylandFull
      winetricks
    ];

  programs = {
    gamemode.enable = true; # Add "gamemoderun %command%" to launch options to use gamemode
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
    };
  };
}


# You can combine launch options like this:
# gamemoderun mangohud %command%