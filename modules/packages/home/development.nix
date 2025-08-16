{ pkgs, ... }: {

  home = {
    packages = with pkgs; [
 
      # Development
      git
      nixfmt-rfc-style
    ];
  };
}
