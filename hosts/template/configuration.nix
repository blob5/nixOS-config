{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    # Core
    ../../modules/core/default.nix

    # Drivers (pick one if needed)
    # ../../modules/drivers/amd.nix
    # ../../modules/drivers/nvidia.nix

    # Services
    # ../../modules/services/nixos/audio.nix
    # ../../modules/services/nixos/sddm.nix

    # Packages
    # ../../modules/packages/nixos/services.nix
    # ../../modules/packages/nixos/utils.nix
    # ../../modules/packages/nixos/desktop.nix
    # ../../modules/packages/nixos/applications.nix
  ];

  # Host-specific system packages
  environment.systemPackages = with pkgs; [
    # Add system packages here
  ];

  # Original install version
  system.stateVersion = "25.11";
}
