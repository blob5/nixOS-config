{
  description = "NixOS";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
  
    ags.url = "github:Aylur/ags";

    fastanime.url = "github:Benexl/fastanime";
    lobster.url = "github:justchokingaround/lobster";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 

    stylix.url = "github:danth/stylix";  
   
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
    };
 
    textfox.url = "github:adriankarlen/textfox";
 
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };

    minegrub-world-sel-theme.url = "github:Lxtharia/minegrub-world-sel-theme";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    hyprland.url = "github:hyprwm/Hyprland";  
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
    let
      # Import host settings from their respective directories
      hosts = {
        cyberia = import ./hosts/cyberia/settings.nix;
        navi = import ./hosts/navi/settings.nix;
      };

      userSettings = {
        username = "blob";
        name = "blob";
        dotfilesDir = "~/.config/nixos";
      };

      # Function to create a NixOS configuration for a given host
      mkNixosConfiguration = hostName: hostSettings:
        let
          overlayPkgs = import nixpkgs {
            system = hostSettings.system;
            config = {
              allowUnfree = true;
            };
            overlays = [
              inputs.hyprpanel.overlay
            ];
          };
        in
        nixpkgs.lib.nixosSystem {
          system = hostSettings.system;
          modules = [
            ./hosts/${hostName}/configuration.nix
            inputs.minegrub-world-sel-theme.nixosModules.default
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.backupFileExtension = "backup";
              home-manager.useUserPackages = true;
              home-manager.users.${userSettings.username} = { config, ... }: {
                imports = [ ./hosts/${hostName}/home.nix ];
                _module.args.pkgs = overlayPkgs;
              };
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
