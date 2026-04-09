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
                nvim-tree-lua
                alpha-nvim
                telescope-nvim
                gitsigns-nvim
                lualine-nvim
                which-key-nvim
                bufferline-nvim
                nvim-autopairs
                comment-nvim
                indent-blankline-nvim
                todo-comments-nvim
            ];
            extraPackages = with pkgs; [
                ripgrep
                fd
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