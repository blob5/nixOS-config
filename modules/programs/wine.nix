{pkgs, ...}: 

{
  environment.systemPackages = with pkgs; [
      wineWow64Packages.stagingFull
      winetricks
      bottles # easy wine prefix management
      wineWow64Packages.yabridge
    ];
}
