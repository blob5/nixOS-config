# modules/programs/terminals/zsh/zsh.nix
{ inputs, systemSettings, flakeRoot, ... }: 

let
  hostSettings = import "${inputs.self}/hosts/${systemSettings.hostname}/settings.nix";
in
{

  # Import the viu zsh completions
  home.file.".config/zsh/completions/viu.zsh".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/Benexl/viu/refs/heads/master/completions/viu.zsh";
    sha256 = "1cw3rbhrrqc8nann9ymjdmqpn1pa1gj4f15n92cwvc4pb2amcfcf";
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
      repair = "sudo nix-store --verify --repair";
      vi = "vim";
      n = "nvim";
      q = "exit";
      c = "code .";
      r = "cd nix; code .";
      spf = "superfile";
      cd = "z"; # replace cd with zoxide
      ls = "eza"; # replace ls with eza
      please = "sudo !!";

      anime = "viu anilist";

      # aliases for my custom functions
      nixos-btw = "myfsinfo";

      # Text manipulation aliases
      clr = "clear";  # Clear screen
      cll = "clear && ls";  # Clear screen and list files
      cla = "clear && ls -la";  # Clear screen and list all files
      
      # Development alias
      waybar-dev = "_waybar_dev";

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

      # Pull request tracker for nixpkgs
      nixpr() {
        curl -s "https://blog.nyaw.xyz/api/pr-stat?pr=$1" | jq
      }



      # Waybar development mode
      # This function starts waybar in a loop, 
      # watching for changes in the config and modules files.
      _waybar_dev() {
        local MODULES="${hostSettings.flakeRoot}/modules/desktop/waybar/${hostSettings.compositor}-modules.jsonc"
        local CONFIG="${hostSettings.flakeRoot}/modules/desktop/waybar/config.jsonc"
        local STYLE="${hostSettings.flakeRoot}/modules/desktop/waybar/style.css"
        local TMP_CONFIG="/tmp/waybar-dev-merged-config.jsonc"
        local CONFIG_DIR="$(dirname "$CONFIG")"

        # Kill all existing Waybar instances before starting
        if pidof waybar > /dev/null; then
          echo "[waybar-dev] Killing all existing Waybar processes..."
          killall waybar
          sleep 1  # Give it a moment to shut down cleanly
        fi

        # Start waybar loop in background
        (
          cd "$CONFIG_DIR" || {
            echo "[waybar-dev] ERROR: Failed to cd $CONFIG_DIR"
            exit 1
          }
          while true; do
            echo "[waybar-dev] Launching Waybar..."
            waybar -c "$TMP_CONFIG" -s "$STYLE"
            echo "[waybar-dev] Waybar crashed or exited. Restarting in 1 second..."
            sleep 1
          done
        ) &
        local WAYBAR_LOOP_PID=$!

        # Watch for config/module changes and reload Waybar
        {
          printf "%s\n%s\n" "$CONFIG" "$MODULES"
        } | entr -r sh -c '
          echo "[waybar-dev] Change detected. Re-merging configs..."
          jq -s ".[0] * .[1]" "'"$CONFIG"'" "'"$MODULES"'" > "'"$TMP_CONFIG"'"

          # Get fresh PIDs right here
          WAYBAR_PIDS=$(pidof waybar)

          if [ -z "$WAYBAR_PIDS" ]; then
            echo "[waybar-dev] No Waybar process to reload, skipping."
            exit 0
          fi

          echo "[waybar-dev] Sending SIGUSR2 to Waybar (PID(s): $WAYBAR_PIDS) for reload..."
          for pid in $WAYBAR_PIDS; do
            kill -12 "$pid"
          done

          # Give Waybar some time to reload
          sleep 1

          # Check if Waybar still runs (fresh check)
          WAYBAR_PIDS_AFTER=$(pidof waybar)

          if [ -z "$WAYBAR_PIDS_AFTER" ]; then
            echo "[waybar-dev] Waybar not found after reload, loop will restart it."
          else
            echo "[waybar-dev] Waybar still running after reload signal (PID(s): $WAYBAR_PIDS_AFTER)."
          fi
        '

        echo "[waybar-dev] Exiting, killing waybar loop..."
        kill "$WAYBAR_LOOP_PID" 2>/dev/null
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

      # Load zsh viu completions
      source ~/.config/zsh/completions/viu.zsh


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
