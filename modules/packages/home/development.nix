{ pkgs, ... }: {

  home = {
    packages = with pkgs; [
 
      # Development
      git
      nixfmt
      python315
    ];
  };

  programs.java = {
    enable = true;
    package = pkgs.jdk25;
  };
}
