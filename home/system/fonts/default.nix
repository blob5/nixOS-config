# home/system/fonts/default.nix
{ config, lib, pkgs, ... }: {
	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
		otf-font-awesome
		ubuntu-font-family
		papirus-icon-theme
		font-awesome
		noto-fonts
		noto-fonts-cjk
		noto-fonts-emoji
		nerdfonts
		twemoji-color-font
		fira-code
		fira-code-symbols
	];
}
