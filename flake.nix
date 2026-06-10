{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lobster = {
      url = "github:justchokingaround/lobster";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    minegrub-world-sel-theme = {
      url = "github:Lxtharia/minegrub-world-sel-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      hostsDir = ./hosts;

      importHostSettings = hostName: import (hostsDir + "/${hostName}/settings.nix");

      # Discover hosts from ./hosts/*/settings.nix and allow per-host opt-out.
      hosts =
        let
          hostEntries = builtins.readDir hostsDir;
          hostNames = builtins.filter (
            name:
            hostEntries.${name} == "directory"
            && builtins.pathExists (hostsDir + "/${name}/settings.nix")
            && name != "template"
            && ((importHostSettings name).enable or true)
          ) (builtins.attrNames hostEntries);
        in
        builtins.listToAttrs (
          map (name: {
            inherit name;
            value = importHostSettings name;
          }) hostNames
        );

      # Function to create a NixOS configuration for a given host
      mkNixosConfiguration =
        hostName: hostSettings:
        let
          userSettings = hostSettings.user;
        in
        nixpkgs.lib.nixosSystem {
          system = hostSettings.system;
          modules = [
            {
              nixpkgs.overlays = [
                inputs.nix-cachyos-kernel.overlays.pinned
                (_: prev: {
                  openldap = prev.openldap.overrideAttrs {
                    doCheck = !prev.stdenv.hostPlatform.isi686;
                  };
                })
              ];
            }

            ./hosts/${hostName}/configuration.nix
            inputs.minegrub-world-sel-theme.nixosModules.default
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.backupFileExtension = "backup";
              home-manager.useUserPackages = true;
              home-manager.useGlobalPkgs = true;

              home-manager.users.${userSettings.username} =
                { config, ... }:
                {
                  imports = [ ./hosts/${hostName}/home.nix ];
                };

              home-manager.sharedModules = [
                inputs.nixcord.homeModules.nixcord
                inputs.stylix.homeModules.stylix
              ];

              home-manager.extraSpecialArgs = {
                inherit inputs;
                inherit hostSettings;
                systemSettings = hostSettings;
                inherit userSettings;
              };
            }
          ];
          specialArgs = {
            inherit inputs;
            inherit hostSettings;
            systemSettings = hostSettings;
            inherit userSettings;
          };
        };
    in
    {
      # Set a standard formatter
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;

      # Generate configurations for all hosts
      nixosConfigurations = nixpkgs.lib.mapAttrs mkNixosConfiguration hosts;
    };
}
