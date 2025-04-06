{ config, pkgs, ... }:

{
  networking.hostName = "navi";
  networking.networkmanager.enable = true;

  networking.wireguard.enable = true;
  networking.firewall.enable = true;

  networking.nat = {
    enable = true;
    internalInterfaces = [ "wg0" ];
    externalInterface = "enp3s0";   
  };
}