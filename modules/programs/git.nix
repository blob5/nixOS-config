{ ... }:
{
  # Host-specific git settings
  programs.git = {
    enable = true;
    userName = "blob5";
    userEmail = "101657201+blob5@users.noreply.github.com";
    signing = {
      key = "77EC7100CA8F93A1";
      signByDefault = true;
    };
  };
}
