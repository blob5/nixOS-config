{ pkgs, hostSettings, ... }:
let
  role = hostSettings.role or "desktop";
  isGraphical = role != "server";
in
{
  services.udiskie = {
    enable = isGraphical;
    settings = {
      program_options = {
        file_manager = "${pkgs.nautilus}/bin/nautilus";
      };
    };
  };
}
