{ pkgs, ... }: {

  home = {
    packages = with pkgs; [
 
      # Development
      openjdk
      git
      python312
      nodejs_24
      nixfmt-rfc-style
    ];
  };
}
