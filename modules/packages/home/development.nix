{ pkgs, ... }: {

  home = {
    packages = with pkgs; [
 
      # Development
      git
      nixfmt
      python312
    ];
  };

  programs.java = {
    enable = true;
    package = pkgs.jdk25;
  };
}
