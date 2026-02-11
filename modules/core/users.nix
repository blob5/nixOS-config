{ config, pkgs, userSettings, ... }:

{
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = userSettings.extraGroups;
    shell = pkgs.zsh;
    packages = with pkgs; [
      # Add any additional packages for the user here
    ];
    openssh.authorizedKeys.keys = userSettings.sshAuthorizedKeys;
  };
}
