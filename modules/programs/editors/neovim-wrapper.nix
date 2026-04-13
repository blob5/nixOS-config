{ inputs, pkgs, lib, ... }:
let
  wrappedNvim = inputs.wrappers.lib.evalPackage [
    ({ wlib, ... }: {
      pkgs    = pkgs;
      imports = [ wlib.wrapperModules.neovim ];
      settings.config_directory = ./nvim-config;
      specs.start = with pkgs.vimPlugins; [
        plenary-nvim
        nvim-web-devicons
        nui-nvim
        dressing-nvim
        render-markdown-nvim
        alpha-nvim
        bufferline-nvim
        lualine-nvim
        nvim-tree-lua
        indent-blankline-nvim
        gitsigns-nvim
        nvim-autopairs
        comment-nvim
        hardtime-nvim
        which-key-nvim
        fzf-lua
        nvim-lspconfig
        # aider.nvim is not yet in nixpkgs vimPlugins — fetch it directly:
        (pkgs.vimUtils.buildVimPlugin {
          pname = "aider-nvim";
          version = "unstable";
          src = pkgs.fetchFromGitHub {
            owner = "joshuavial";
            repo  = "aider.nvim";
            rev   = "main";
            hash  = "sha256-JJP1om3cJQC1/0wh2GFQCnMhPBgCKsiLZxc+xiuxjzg=";
          };
        })
      ];
      extraPackages = with pkgs; [
        ripgrep
        fd
        fzf
        lsof
        procps
        aider-chat
        nixd
        nixfmt-rfc-style
      ];
    })
  ];
in
{
  home.packages = [ wrappedNvim pkgs.nixd pkgs.nixfmt-rfc-style ];
  home.sessionVariables = {
    EDITOR = lib.getExe wrappedNvim;
    VISUAL = lib.getExe wrappedNvim;
  };
}