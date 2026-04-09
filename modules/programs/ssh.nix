{ ... }:

{
  programs.ssh = {
    enable = true;
    
    # Disable IPv6 to fix slow git: https://stackoverflow.com/a/59614801
    extraConfig = ''
      AddressFamily inet 
    '';
  };
}
