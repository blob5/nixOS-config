{ pkgs, ... }: {

  home = {
    packages = with pkgs; [
 
      # Development
      openjdk
      git
      python312
      nodejs
      nixfmt-rfc-style
    ];
  };
}
