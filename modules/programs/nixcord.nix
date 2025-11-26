{ ... }:

{
  programs.nixcord = {
    enable = true;
    discord = {
      enable = true;
      equicord.enable = true;
      autoscroll.enable = true;
      openASAR.enable = false;
      vencord.enable = false;
    };
    
    config.plugins = {
      gifCollections = {
        enable = true;
        preventDuplicates = true;
        onlyShowCollections = true;
      };
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
      mutualGroupDMs.enable = true;
      newGuildSettings.enable = true;
      openInApp.enable = true;
      shikiCodeblocks = {
        enable = true;
        theme = "https://raw.githubusercontent.com/shikijs/textmate-grammars-themes/ecd9fb1b4a38381df95048c19cf9b8bdcbb1ec09/packages/tm-themes/themes/github-dark-default.json";
        useDevIcon = "COLOR";
      };
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
