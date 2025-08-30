{ inputs, systemSettings, ... }: 

let
  hostSettings = import "${inputs.self}/hosts/${systemSettings.hostname}/settings.nix";
in
{
  # Host-specific git settings
  programs.git = {
    enable = true;
    userName = "blob5";
    userEmail = "101657201+blob5@users.noreply.github.com";
    signing = {
      key = "${hostSettings.gpgkey}";
      signByDefault = true;
    };
  };
}
