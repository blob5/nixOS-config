{ ... }:

{
  imports = [
    ../../../modules/core/default.nix
    ../../../modules/packages/nixos/services.nix
    ../../../modules/packages/nixos/syncthing.nix
    ../../../modules/packages/nixos/utils.nix
  ];
}
