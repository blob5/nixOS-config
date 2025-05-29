{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    profiles.default.userSettings = {
      # Appearance
      "window.titleBarStyle" = "custom";
      "editor.smoothScrolling" = true;
      "editor.cursorBlinking" = "smooth";
      "editor.cursorSmoothCaretAnimation" = "on";
      "workbench.list.smoothScrolling" = true;
      "terminal.integrated.smoothScrolling" = true;

      # Nix LSP settings
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.serverSettings.nil.formatting.command" = "nixfmt";

      # General settings
      "files.autoSave" = "onWindowChange";
      "redhat.telemetry.enabled" = false;
      "workbench.colorTheme" = "One Dark Theme";

      # Git settings
      "git.autofetch" = true;
      
    };
  };

  programs.java = {
    enable = true;
    package = pkgs.jdk;
  };
}