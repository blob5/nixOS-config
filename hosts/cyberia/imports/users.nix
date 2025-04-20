{ config, pkgs, ... }:

{
  users.users.blob = {
    isNormalUser = true;
    description = "blob";
    extraGroups = [ "networkmanager" "wheel" "docker" "wireshark" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      # Add any additional packages for the user here
    ];
  };
}
