{ pkgs, ...}:

{
  # Set default desktop entries for applications
  xdg.desktopEntries = {
    kitty = {
      name = "Kitty";
      exec = "kitty";
      icon = "kitty";
      categories = [ "System" "TerminalEmulator" ];
      settings = {
        Keywords = "terminal;shell;cmd;";
      };
    };
  };
}