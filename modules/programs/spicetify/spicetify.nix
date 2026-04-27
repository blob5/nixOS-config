# modules/programs/spicetify/spicetify.nix
{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in
    {
      enable = true;

      enabledExtensions = with spicePkgs.extensions; [
        hidePodcasts
        autoVolume
      ];

      enabledCustomApps = with spicePkgs.apps; [
        newReleases
      ];

      enabledSnippets = with spicePkgs.snippets; [
        pointer
        removeTheArtistsAndCreditsSectionsFromTheSidebar
        hideMiniPlayerButton
        hideWhatsNewButton
        hideFriendActivityButton
      ];

      theme = {
        name = "Glassify";

        src = pkgs.runCommand "spicetify-glassify-theme" { } ''
          mkdir -p "$out"
          cp ${pkgs.fetchurl {
            url = "https://spicetify-glassify.sanooj.uk/spice/user.css";
            hash = "sha256-a/QjdsS3lygsRGA1cD0vITeClfeSWPjKnCiH/+aRw0w=";
          }} "$out/user.css"
          cp ${pkgs.fetchurl {
            url = "https://spicetify-glassify.sanooj.uk/spice/theme.js";
            hash = "sha256-ChTIMwJD3efk58A6evM2RVXPCzttdevLScKYnY3U5LE=";
          }} "$out/theme.js"
          cp ${pkgs.fetchurl {
            url = "https://spicetify-glassify.sanooj.uk/spice/color.ini";
            hash = "sha256-/JfB/GXbuBw0s3eGztfpVmfSq2EQI+MzF/5zBMEgbjs=";
          }} "$out/color.ini"
        '';
      }; 

      colorScheme = "dark";
    };
}
