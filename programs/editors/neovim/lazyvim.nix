# programs/editors/neovim/lazyvim.nix
{ config, lib, pkgs, ... }:

let
  # Function to create declarative neovim configurations
  mkNeovimConfig = { name, configDir }:
    let
      nvim-full = pkgs.neovim.override { withNodeJs = true; };
      deps = with pkgs; [
        ripgrep
        fd
        git
        lazygit
        gcc
        nodePackages.prettier
        nodePackages.typescript
        nodePackages.typescript-language-server
        lua-language-server
        stylua
        python3Full
        black
      ];
      
      # Create a derivation for the configuration
      configDerivation = pkgs.stdenv.mkDerivation {
        name = "${name}-config";
        src = configDir;
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out
          cp -r $src/* $out/
        '';
      };
      
    in pkgs.symlinkJoin {
      inherit name;
      paths = [ nvim-full ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        mkdir -p $out/share/${name}
        cp -r ${configDerivation}/* $out/share/${name}/
        
        wrapProgram $out/bin/nvim \
          --set "NVIM_APPNAME" "${name}" \
          --set "XDG_CONFIG_HOME" "$out/share" \
          --suffix "PATH" ":" "${lib.makeBinPath deps}"
      '';
    };
in {
  # Create LazyVim distribution
  environment.systemPackages = [
    # LazyVim with declarative configuration
    (mkNeovimConfig {
      name = "lazyvim";
      configDir = pkgs.fetchFromGitHub {
        owner = "LazyVim";
        repo = "starter";
        rev = "master";
        sha256 = "0lr0ijn3xrbg4qsva3ma5zjanxjb7qa0dsn31gw5bbzq62a6gfj2";
      };
    })
    
    # Required dependencies
    pkgs.ripgrep
    pkgs.fd
    pkgs.lazygit
    pkgs.gcc
    pkgs.git
    
    # Additional useful tools for development
    pkgs.nodePackages.prettier
    pkgs.nodePackages.typescript
    pkgs.nodePackages.typescript-language-server
    pkgs.lua-language-server
    pkgs.stylua
    pkgs.python3Full
    pkgs.black
  ];
}