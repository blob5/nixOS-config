# home/programs/zsh/default.nix
{ config, lib, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake ~/.config/nixos";
      n = "neovide";
      vi = "vim";
      nv = "nvim";
      q = "exit";
    };
    
    history = {
      expireDuplicatesFirst = true;
      ignoreSpace = false;
      save = 15000;
      share = true;
    };

    plugins = [
      {
        name = "zsh-colored-man-pages";
        file = "colored-man-pages.plugin.zsh";
        src = builtins.fetchGit {
          url = "https://github.com/ael-code/zsh-colored-man-pages";
          rev = "57bdda68e52a09075352b18fa3ca21abd31df4cb";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        file = "zsh-syntax-highlighting.zsh";
        src = builtins.fetchGit {
          url = "https://github.com/zsh-users/zsh-syntax-highlighting";
          rev = "932e29a0c75411cb618f02995b66c0a4a25699bc";
        };
      }
      {
        name = "pure";
        src = builtins.fetchGit {
          url = "https://github.com/sindresorhus/pure";
          rev = "8ec575c886c8bb33a87f80b9710ee5e379a0b589";
        };
      }
    ];
  };
}
