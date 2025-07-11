{ config, pkgs, ... }:

{

  # System-level configurations
  environment.systemPackages = with pkgs; [

  ];

    # Programs
  programs.wireshark.enable = true;
  programs.firefox.enable = true;
  programs.fish.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };


  # Services
  programs.nix-ld.enable = true;

}
