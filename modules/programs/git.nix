{ inputs, systemSettings, ... }: 

let
  hostSettings = import "${inputs.self}/hosts/${systemSettings.hostname}/settings.nix";
in
{
  # Host-specific git settings
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "101657201+blob5@users.noreply.github.com";
        name = "blob5";
      };
    };
    signing = {
      key = "${hostSettings.gpgkey}";
      signByDefault = true;
    };
  };
}
