{ inputs, pkgs, lib, ... }:

let
  wrappedNvim = inputs.wrappers.lib.evalPackage [
    ({ wlib, ... }: {
      pkgs = pkgs;
      imports = [ wlib.wrapperModules.neovim ];
      settings.config_directory = ./nvim-config;

      specs.start = with pkgs.vimPlugins; [
        plenary-nvim
        nvim-web-devicons
        nui-nvim

        # UI
        alpha-nvim
        bufferline-nvim
        lualine-nvim
        nvim-tree-lua
        indent-blankline-nvim
        noice-nvim

        # Git
        gitsigns-nvim

        # Editing
        nvim-autopairs
        comment-nvim
        todo-comments-nvim
        hardtime-nvim
        which-key-nvim

        # Search
        fff-nvim

        # AI
        sidekick-nvim
      ];

      extraPackages = with pkgs; [
        # CLI tools
        ripgrep
        fd
        lsof
        procps
        
        # LSP
        copilot-language-server
      ];
    })
  ];
in
{
  home.packages = [ wrappedNvim ];
  home.sessionVariables = {
    EDITOR = lib.getExe wrappedNvim;
    VISUAL = lib.getExe wrappedNvim;
  };
}