{
  description = "NixOS";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
  
    ags.url = "github:Aylur/ags";
 
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

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    minegrub-world-sel-theme.url = "github:Lxtharia/minegrub-world-sel-theme";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    hyprland.url = "github:hyprwm/Hyprland";  
  };

  outputs = { self, nixpkgs, home-manager, stylix, ... }@inputs:
  let
    systemSettings = {
      system = "x86_64-linux";
      hostname = "cyberia";
      timezone = "Europe/Amsterdam";
      locale = "en_US.UTF-8";
      version = "24.05";
    };

    userSettings = {
      username = "blob";
      name = "blob";
      dotfilesDir = "~/.config/nixos";
    };

    overlayPkgs = import nixpkgs {
      system = systemSettings.system;
      config = {
        allowUnfree = true;
      };
      overlays = [
        inputs.hyprpanel.overlay
      ];
    };
  in {
    nixosConfigurations.${systemSettings.hostname} = nixpkgs.lib.nixosSystem {
      system = systemSettings.system;
      modules = [
        ./hosts/${systemSettings.hostname}/configuration.nix
        inputs.minegrub-world-sel-theme.nixosModules.default
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.backupFileExtension = "backup";
          home-manager.useUserPackages = true;
          home-manager.users.${userSettings.username} = { config, ... }: {
            imports = [ ./hosts/${systemSettings.hostname}/home.nix ];
            _module.args.pkgs = overlayPkgs;
          };
          home-manager.extraSpecialArgs = {
            inherit inputs;
            inherit systemSettings;
            inherit userSettings;
          };
        }
      ];
      specialArgs = {
        inherit inputs;
        inherit systemSettings;
        inherit userSettings;
      };
    };
  };
}
