{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    colorschemes.monokai-pro = {
      enable = true;
      settings.transparent_background = true;
    };
    
    plugins = {
      treesitter = { # syntax highlighting
        enable = true;

        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          json
          lua
          make
          markdown
          nix
          regex
          toml
          vim
          vimdoc
          xml
          yaml
        ];
      };
      telescope.enable = true; # fuzzy finder
      blink-cmp.enable = true; # autocompletion
      neo-tree.enable = true; # file explorer
      gitsigns.enable = true; # inline git indicators
      fugitive.enable = true; # git integration
      lualine.enable = true; # statusline
      dashboard.enable = true; # start screen
      web-devicons.enable = true; # nerdfont icons
    };
  };
}