{ config, pkgs, ... }:

{
	# Enable Steam and Lutris
  environment.systemPackages = with pkgs; [
	# Games
	modrinth-app
	lutris
  ];


  # Enable Steam
  programs.steam.enable = true;
}