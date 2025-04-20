{ config, pkgs, ... }:

{
	nix.settings.auto-optimise-store = true;
	nix.gc.automatic = true;
}
