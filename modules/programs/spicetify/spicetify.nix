# modules/programs/spicetify/spicetify.nix
{ inputs, config, lib, pkgs, ... }: 

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
        adblock
        hidePodcasts
        autoVolume
        shuffle # shuffle+
        betterGenres
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

      theme = spicePkgs.themes.defaultDynamic;
    };
}