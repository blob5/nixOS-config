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
        name = "Liquify";

        src = pkgs.fetchFromGitHub {
          owner = "NMWplays";
          repo = "Liquify";
          rev = "9c7aad2e3c411205520f6e7efe2bb718a718d5a0";
          hash = "sha256-aUB7DmJNWWGCA/Gu2u5z45aF52q2QK9mVkTCVLxngcc=";
        };
      };

      colorScheme = "Base";
    };
}
