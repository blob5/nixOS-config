{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    viu.url = "github:benexl/viu";
    viu.inputs.nixpkgs.follows = "nixpkgs";

    lobster.url = "github:justchokingaround/lobster";
    lobster.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix"; 
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    minegrub-world-sel-theme.url = "github:Lxtharia/minegrub-world-sel-theme";
    minegrub-world-sel-theme.inputs.nixpkgs.follows = "nixpkgs";

    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    nixcord.url = "github:kaylorben/nixcord";
    nixcord.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    noctalia.url = "github:noctalia-dev/noctalia-shell";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    nix-cachyos-kernel.inputs.nixpkgs.follows = "nixpkgs";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let


      # Import host settings from their respective directories
      hosts = {
        cyberia = import ./hosts/cyberia/settings.nix;
        navi = import ./hosts/navi/settings.nix;
        core = import ./hosts/core/settings.nix;
	      cache =  import ./hosts/cache/settings.nix;
      };

      # Function to create a NixOS configuration for a given host
      mkNixosConfiguration = hostName: hostSettings:
        let
          userSettings = hostSettings.user;
        in
        nixpkgs.lib.nixosSystem {
          system = hostSettings.system;
          modules = [
            {
              nixpkgs.overlays = [
                inputs.nix-cachyos-kernel.overlays.pinned
              ];
            }

            ./hosts/${hostName}/configuration.nix
            inputs.minegrub-world-sel-theme.nixosModules.default
            inputs.stylix.nixosModules.stylix
            
            home-manager.nixosModules.home-manager {
              home-manager.backupFileExtension = "backup";
              home-manager.useUserPackages = true;
              home-manager.useGlobalPkgs = true;
              
              home-manager.users.${userSettings.username} = { config, ... }: {
                imports = [ ./hosts/${hostName}/home.nix ];
            };

              home-manager.sharedModules = [
                inputs.nixcord.homeModules.nixcord
                inputs.stylix.homeModules.stylix
                inputs.nixvim.homeModules.nixvim
              ];

              home-manager.extraSpecialArgs = {
                inherit inputs;
                systemSettings = hostSettings;
                inherit userSettings;
              };
            }
          ];
          specialArgs = {
            inherit inputs;
            systemSettings = hostSettings;
            inherit userSettings;
          };
        };
    in {
      # Generate configurations for all hosts
      nixosConfigurations = nixpkgs.lib.mapAttrs mkNixosConfiguration hosts;
    };
}
