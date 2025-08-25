{ ... }:
{
  # Host-specific git settings
  programs.git = {
    enable = true;
    userName = "blob5";
    userEmail = "101657201+blob5@users.noreply.github.com";
    signing = {
      key = "F1C140E19A2300F1";
      signByDefault = true;
    };
  };
}
