{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    profiles.default.userSettings = {
      # Appearance
      "window.titleBarStyle" = "custom";
      "window.menuBarVisibility" = "compact";


      "editor.smoothScrolling" = true;
      "editor.cursorBlinking" = "smooth";
      "editor.cursorSmoothCaretAnimation" = "on";
      "workbench.list.smoothScrolling" = true;
      "terminal.integrated.smoothScrolling" = true;

      # Nix LSP settings
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixfmt";

      # General settings
      "files.autoSave" = "onWindowChange";
      "redhat.telemetry.enabled" = false;
      "workbench.colorTheme" = "One Dark Theme";
      "editor.fontFamily" =  "'JetBrainsMono Nerd Font', 'FiraCode Nerd Font', 'Font Awesome 6 Free Solid', 'Font Awesome 5 Free Solid', 'Font Awesome 6 Free', 'Font Awesome 5 Free', 'Symbola', monospace";
      # Git settings
      "git.autofetch" = true;

      # copilot settings
      "chat.agent.maxRequests" = 250;
    };
  };

}