{ pkgs, ... }: {

  home = {
    packages = with pkgs; [
 
      # Development
      git
      nixfmt
    ];
  };

  programs.java = {
    enable = true;
    package = pkgs.jdk25;
  };
}
