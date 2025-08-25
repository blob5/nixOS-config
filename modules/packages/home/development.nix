{ pkgs, ... }: {

  home = {
    packages = with pkgs; [
 
      # Development
      git
      nixfmt-rfc-style
    ];
  };

  programs.java = {
    enable = true;
    package = pkgs.jdk24;
  };
}
