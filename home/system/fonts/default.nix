# home/system/fonts/default.nix
{ config, lib, pkgs, ... }: {
	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
		otf-font-awesome
		noto-fonts-cjk
		ubuntu-font-family
		papirus-icon-theme
		font-awesome
	];
}
