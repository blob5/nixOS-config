{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  wrappedNvim = inputs.wrappers.lib.evalPackage [
    (
      { wlib, ... }:
      {
        pkgs = pkgs;
        imports = [ wlib.wrapperModules.neovim ];

        settings.config_directory = ./nvim-config;

        specs.start = with pkgs.vimPlugins; [
          # ui
          alpha-nvim
          bufferline-nvim
          dressing-nvim
          indent-blankline-nvim
          lualine-nvim
          nvim-web-devicons
          render-markdown-nvim

          # editing
          comment-nvim
          hardtime-nvim
          nvim-autopairs

          # navigation
          fzf-lua
          nvim-tree-lua

          # git
          gitsigns-nvim

          # lsp
          nvim-lspconfig

          # ai
          opencode-nvim

          # misc
          nui-nvim
          plenary-nvim
          which-key-nvim
        ];

        extraPackages = with pkgs; [
          # tools
          fd
          fzf
          lsof
          procps
          ripgrep

          # ai
          opencode

          # nix
          nixd
          nixfmt
        ];
      }
    )
  ];
in
{
  home.packages = [
    wrappedNvim
    pkgs.nixd
    pkgs.nixfmt-rfc-style
  ];

  home.sessionVariables = {
    EDITOR = lib.getExe wrappedNvim;
    VISUAL = lib.getExe wrappedNvim;
  };
}
