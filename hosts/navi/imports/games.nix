{ config, pkgs, ... }:

{
	# Enable Steam and Lutris
  environment.systemPackages = with pkgs; [
	# Games
	modrinth-app-unwrapped
	prismlauncher
	lutris
  ];


  # Enable Steam
  programs.steam.enable = true;
}