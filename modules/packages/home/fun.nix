{ pkgs, ... }: {

  home = {
    packages = with pkgs; [
 
      # Fun
      sl
      cowsay
      cmatrix
      hollywood
      aalib
      pipes
      asciiquarium-transparent
      cava
    ];
  };
}
