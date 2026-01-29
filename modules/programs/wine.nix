{pkgs, ...}: 

{
  environment.systemPackages = with pkgs; [
      wineWowPackages.stagingFull
      winetricks
      wineasio
      bottles # easy wine prefix management
      wineWowPackages.yabridge
    ];
}
