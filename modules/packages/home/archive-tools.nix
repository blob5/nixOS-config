{ pkgs, ... }: {

  home = {
    packages = with pkgs; [
      # Archive tools
      p7zip
      unzip
      zip
      xz
    ];
  };
}
