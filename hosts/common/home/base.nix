{ ... }:

{
  imports = [
    ../../../modules/programs/editors/neovim-wrapper.nix
    ../../../modules/programs/opencode.nix
    ../../../modules/programs/terminals/zsh/zsh.nix
    ../../../modules/programs/git.nix
    ../../../modules/packages/home/archive-tools.nix
    ../../../modules/packages/home/CLI-tools.nix
    ../../../modules/packages/home/home-manager.nix
  ];
}
