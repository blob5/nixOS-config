{ inputs, pkgs, ... }: {

  home = {
    packages = with pkgs; [
 
      # Media Entertainment 
      inputs.lobster.packages."${system}".lobster
      inputs.fastanime.packages."${system}".default
      ffmpeg
      (mpv.override { scripts = [
        mpvScripts.uosc
        mpvScripts.thumbfast
        mpvScripts.mpris
      ]; })
      chafa
      ani-skip
      feh    
    ];
  };
}
