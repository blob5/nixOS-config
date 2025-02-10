{ config, pkgs, ... }:

{
  users.users.blob = {
    isNormalUser = true;
    description = "blob";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    git = {
      username = "blob";
      email = "101657201+blob5@users.noreply.github.com";
    };
    packages = with pkgs; [
      # Add any additional packages for the user here
    ];
  };
}