{ ... }:

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    transcoding = {
      enableSubtitleExtraction = true;
      deleteSegments = true;
    };
  };
}
