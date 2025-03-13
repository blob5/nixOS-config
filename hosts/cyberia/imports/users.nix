{ config, pkgs, ... }:

{
  users.users.blob = {
    isNormalUser = true;
    description = "blob";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      # Add any additional packages for the user here
    ];
  };
}
