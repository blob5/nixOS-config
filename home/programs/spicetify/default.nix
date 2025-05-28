# home/programs/spicetify/default.nix
{ inputs, config, lib, pkgs, ... }: {
imports = [
  # For home-manager
  inputs.spicetify-nix.homeManagerModules.default
];

programs.spicetify =
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  enable = true;

  enabledExtensions = with spicePkgs.extensions; [
    adblock
    hidePodcasts
    autoVolume
    shuffle # shuffle+ (special characters are sanitized out of extension names)
    betterGenres

  ];
  enabledCustomApps = with spicePkgs.apps; [
    newReleases
    #ncsVisualizer
  ];
  enabledSnippets = with spicePkgs.snippets; [
    #rotatingCoverart
    pointer
  ];
 };
}
