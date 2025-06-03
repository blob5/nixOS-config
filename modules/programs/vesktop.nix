{ ... }:

{

  programs.vesktop.enable = true;
  programs.vesktop.settings = {
    hardwareAcceleration = true;
    minimizeToTray = false;
    tray = false;
  };
  programs.vesktop.vencord.settings.plugins = {
    CallTimer = true;
    BetterGifPicker = true;
    CrashHandler = true;
    FakeNitro = true;
    FavoriteGifSearch = true;
    FixSpotifyEmbeds = true;
    ForceOwnerCrown = true;
    FriendsSince = true;
    ImageZoon = true;
    MemberCount = true;
    MessageLogger = true;
    MutualGroupDMs = true;
    NewGuildSettings = true;
    OpenInApp = true;
    ShikiCodeblocks = true;
    SilentMessageToggle = true;
    SpotifyCrack = true;
    VolumeBooster = true;
    WebScreenShareFixes = true;
    WebKeybinds = true;
    YoutubeAdblock = true;
    StartupTimings = true;
    RelationshipNotifier = true;
    BetterSettings = true;
    LoadingQuotes = true;
  };
}