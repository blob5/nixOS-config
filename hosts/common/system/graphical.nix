{ ... }:

{
  imports = [
    ./base.nix
    ../../../modules/services/nixos/audio.nix
    ../../../modules/services/nixos/sddm.nix
    ../../../modules/packages/nixos/desktop.nix
    ../../../modules/packages/nixos/applications.nix
  ];
}
