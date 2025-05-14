{ config, pkgs, ... }:

{
	# Enable Steam and Lutris
  environment.systemPackages = with pkgs; [
	# Games
	prismlauncher
  ];


  # Enable Steam
  programs.steam.enable = true;
}