{ ... }:

{
  imports = [
    ./base.nix
    ../../../modules/programs/editors/vscode.nix
    ../../../modules/programs/terminals/kitty/kitty.nix
    ../../../modules/programs/spicetify/spicetify.nix
    ../../../modules/programs/nixcord.nix
    ../../../modules/programs/anime4k/anime4k.nix
    ../../../modules/desktop/stylix/stylix.nix
    ../../../modules/desktop/fonts.nix
    ../../../modules/desktop/rofi/rofi.nix
    ../../../modules/desktop/desktop-entries.nix
    ../../../modules/packages/home/applications.nix
    ../../../modules/packages/home/cursor.nix
    ../../../modules/packages/home/development.nix
    ../../../modules/packages/home/entertainment.nix
    ../../../modules/packages/home/fun.nix
  ];
}
