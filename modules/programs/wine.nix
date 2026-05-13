{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wineWow64Packages.stagingFull
    winetricks
    wineWow64Packages.yabridge
  ];
}
