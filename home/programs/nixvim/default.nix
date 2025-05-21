# home/programs/nixvim/default.nix
{ inputs, config, lib, pkgs, ... }: {

imports = [
  # For home-manager
  inputs.nixvim.homeManagerModules.default
];

programs.nixvim = {
  enable = true;

  # Plugins
  plugins = {
    # Core plugins
    telescope.enable = true;
    treesitter.enable = true;
    lsp = {
      enable = true;
      servers = { # Language servers
        nixd.enable = true;
        lua_ls.enable = true;
        vimls.enable = true;
        bashls.enable = true;
        markdown_oxide.enable = true;
        java_language_server.enable = true;
      };
    };
    
    # UI enhancement
    lualine.enable = true;
    nvim-tree.enable = true;
    which-key.enable = true;
    # Noice
    noice.enable = true; # completely replaces the default command line
    # Plugins required by noice
    nui.enable = true;
    notify.enable = true; 



    # Git integration
    gitsigns.enable = true;
  };

  # Theme
  colorschemes.tokyonight.enable = true;
 };
}
