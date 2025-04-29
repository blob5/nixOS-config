# home/programs/zsh/default.nix
{ config, lib, pkgs, ... }: {

  # Import the fastanime zsh completions
  home.file.".config/zsh/completions/fastanime.zsh".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/Benexl/FastAnime/refs/heads/master/completions/fastanime.zsh";
    sha256 = "1bqgfvfwjxk0kl7fqc3vspza4w8cgnq8w6n1k616f45in7hl87c9";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      rebuild = "sudo nixos-rebuild switch --flake ~/.config/nixos";
      upgrade = "sudo nixos-rebuild switch --flake ~/.config/nixos --upgrade";
      update = "nix flake update --flake ~/.config/nixos";
      n = "neovide";
      vi = "vim";
      nv = "nvim";
      q = "exit";
      spf = "superfile";
      cd= "z"; # replace cd with zoxide
      ls = "eza"; # replace ls with eza

      # aliases for my custom functions
      nixos-btw = "myfsinfo";

      # Text manipulation aliases
      clr = "clear";  # Clear screen
      cll = "clear && ls";  # Clear screen and list files
      cla = "clear && ls -la";  # Clear screen and list all files
      
      # Git aliases
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";
      
      # System aliases
      clean = "sudo nix-collect-garbage -d";
      
      
      # File operations
      cp = "cp -i";  # Interactive copy
      mv = "mv -i";  # Interactive move
      rm = "rm -i";  # Interactive remove
      
    };

    initContent = ''
    
    myfsinfo() {
      DEVICE=$(df / | awk 'NR==2 {print $1}')
      sudo tune2fs -l "$DEVICE" | grep 'Filesystem created:'
    }


      bindkey "^[[1;5C" forward-word  # ctrl+left arrow
      bindkey "^[[1;5D" backward-word # ctrl+right arrow
      bindkey "^H" backward-kill-word # ctrl+backspace


      # Enable color support
      export CLICOLOR=1
      export LSCOLORS=GxFxCxDxBxegedabagaced

      # Set default editor
      export EDITOR=nvim

      # Add custom functions
      function mkcd() {
        mkdir -p "$1" && cd "$1"
      }

      function extract() {
        if [ -f "$1" ] ; then
          case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar e "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
          esac
        else
          echo "'$1' is not a valid file"
        fi
      }

      # Quick directory navigation
      function qcd() {
        cd "$(find . -type d | fzf)"
      }

      # Quick grep
      function qgrep() {
        grep -r "$1" . | fzf
      }

      # Load zsh fastanime completions
      source ~/.config/zsh/completions/fastanime.zsh


      eval "$(zoxide init zsh)"
    '';

    
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
