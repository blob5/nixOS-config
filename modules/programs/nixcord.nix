{ ... }:

{
  programs.nixcord = {
    enable = true;
    discord = {
      enable = false;
      equicord.enable = false;
      autoscroll.enable = true;
      openASAR.enable = true;
      vencord.enable = true;
    };

    vesktop = {
      enable = true;
      autoscroll.enable = true;
    };
    
    config.plugins = {
      callTimer.enable = true;
      betterGifPicker.enable = false;
      fakeNitro.enable = true;
      fixSpotifyEmbeds.enable = true;
      forceOwnerCrown.enable = true;
      friendsSince.enable = true;
      imageZoom = {
        enable = true;
        size = 500.0;
      };
      memberCount.enable = true;
      loadingQuotes = {
        enable = true;
        replaceEvents = false;
      };
      messageLogger = {
        enable = true;
        collapseDeleted = true;
        ignoreSelf = true;
      };
      newGuildSettings.enable = true;
      openInApp.enable = true;
      silentMessageToggle.enable = true;
      spotifyCrack = {
        enable = true;
        noSpotifyAutoPause = true;
      };
      volumeBooster = {
        enable = true;
        multiplier = 5.0;
      };
      webScreenShareFixes.enable = true;
      webKeybinds.enable = true;
      youtubeAdblock.enable = true;
      startupTimings.enable = true;
      relationshipNotifier = {
        enable = true;
        notices = true;
      };
      betterSettings.enable = true;
    };
  };
}
