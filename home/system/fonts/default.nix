# home/system/fonts/default.nix
{ config, lib, pkgs, ... }: {
	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
	];
}
