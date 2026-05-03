{ config, pkgs, ... }:

{

  imports = [
    ./hardware-configuration.nix

    ../common/system/graphical.nix

    # Programs/services/modules
    ../../modules/virtualization/virtualization.nix
    ../../modules/programs/gaming/steam.nix
    ../../modules/programs/gaming/minecraft.nix
    ../../modules/programs/wine.nix
    ../../modules/services/nixos/sunshine.nix
    ../../modules/services/nixos/openrgb.nix
    ../../modules/drivers/amd.nix
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  services.hardware.openrgb.motherboard = "amd";
  services.hardware.openrgb.startupProfile = "/home/blob/.config/OpenRGB/gaming.orp";
  hardware.i2c.enable = true;

  networking = {
    interfaces = {
      enp42s0 = {
        wakeOnLan.enable = true;
      };
    };
    firewall = {
      allowedUDPPorts = [ 9 ]; # required for wake on lan
    };
  };

  hardware.wooting.enable = true;
  services.lact.enable = true; # AMD overclocking tool
  hardware.amdgpu.overdrive.enable = true; # Enable AMD overclocking functionality

  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.firmware = [ pkgs.linux-firmware ];

  nixpkgs.config.rocmSupport = true;
  nixpkgs.config.packageOverrides = pkgs: {
    blender-rocm = pkgs.pkgsRocm.blender.overrideAttrs (old: {
      # Disable OSL to avoid LLVM 19 vs 22 symbol collisions in Blender.
      cmakeFlags =
        (builtins.filter
          (flag: flag != (pkgs.lib.cmakeBool "WITH_CYCLES_OSL" true))
          old.cmakeFlags)
        ++ [ (pkgs.lib.cmakeBool "WITH_CYCLES_OSL" false) ];
      buildInputs = builtins.filter
        (pkg: pkg != pkgs.python313Packages.openshadinglanguage)
        old.buildInputs;
      pythonPath = builtins.filter
        (pkg: pkg != pkgs.python313Packages.openshadinglanguage)
        old.pythonPath;
    });
  };

  # Host-specific system packages
  environment.systemPackages = with pkgs; [
    # Drawing
    opentabletdriver
    openrgb-with-all-plugins

    darktable # color grading
    pwntools
    gdb
    blender-rocm
    davinci-resolve
    ungoogled-chromium # for wooting
    gale
  ];

  # Original install version,
  # This is only used by some packages for backwards compatibility.
  # use channels if you want to update package versions.
  # DO NOT UPDATE THIS UNLESS YOU KNOW WHAT YOU ARE DOING
  system.stateVersion = "24.11";
}
