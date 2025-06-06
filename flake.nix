{
  description = "NixOS";

  inputs = {
    libplacebo-pinned.url = "github:NixOS/nixpkgs/12a55407652e04dcf2309436eb06fef0d3713ef3";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    fastanime.url = "github:Benexl/fastanime";
    lobster.url = "github:justchokingaround/lobster";
    better-control.url = "github:rishabh5321/better-control-flake";
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

  outputs = { self, nixpkgs, libplacebo-pinned, home-manager, stylix, ... }@inputs:
    let
      # Add overlay to downgrade libplacebo
      overlay-libplacebo = final: prev: {
        libplacebo = libplacebo-pinned.legacyPackages.${prev.system}.libplacebo;

      };

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
            { nixpkgs.overlays = [ inputs.hyprpanel.overlay overlay-libplacebo ]; }
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
