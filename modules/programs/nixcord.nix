{ ... }:

{
  programs.nixcord = {
    enable = true;
    discord.enable = false; # Disable the default Discord client
  };
  programs.nixcord = {
    vesktop = {
      enable = true;
      autoscroll.enable = true;
    };
    config.plugins = {
      callTimer.enable = true;
      betterGifPicker.enable = true;
      fakeNitro.enable = true;
      favoriteGifSearch.enable = true;
      fixSpotifyEmbeds.enable = true;
      forceOwnerCrown.enable = true;
      friendsSince.enable = true;
      imageZoom.enable = true;
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
        theme = "https://raw.githubusercontent.com/shikijs/shiki/refs/heads/v0/packages/shiki/themes/github-dark.json";
        useDevIcon = "COLOR";
      };
      silentMessageToggle.enable = true;
      spotifyCrack = {
        enable = true;
        noSpotifyAutoPause = true;
      };
      volumeBooster = {
        enable = true;
        multiplier = 10;
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