{
  description = "NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    fastanime.url = "github:Benexl/fastanime";
    lobster.url = "github:justchokingaround/lobster";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix"; 
    stylix.url = "github:danth/stylix";  
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    minegrub-world-sel-theme.url = "github:Lxtharia/minegrub-world-sel-theme";
    niri.url = "github:sodiboo/niri-flake";
    ags.url = "github:Aylur/ags";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    hyprland.url = "github:hyprwm/Hyprland";
    nixcord.url = "github:kaylorben/nixcord";
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
        nixpkgs.lib.nixosSystem {
          system = hostSettings.system;
          modules = [
            ./hosts/${hostName}/configuration.nix
            inputs.minegrub-world-sel-theme.nixosModules.default
            stylix.nixosModules.stylix
            { nixpkgs.overlays = [ inputs.hyprpanel.overlay ]; }
            home-manager.nixosModules.home-manager {
              home-manager.backupFileExtension = "backup";
              home-manager.useUserPackages = true;
              home-manager.users.${userSettings.username} = { config, ... }: {
                imports = [ ./hosts/${hostName}/home.nix ];
              };
              home-manager.sharedModules = [
                inputs.nixcord.homeModules.nixcord
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
