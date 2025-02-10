{ config, pkgs, ... }:

{
  users.users.blob = {
    isNormalUser = true;
    description = "blob";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      # Add any additional packages for the user here
    ];
  };
}