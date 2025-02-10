{ config, pkgs, ... }:

{
  users.users.blob = {
    isNormalUser = true;
    description = "blob";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # Add any additional packages for the user here
    ];
  };
}