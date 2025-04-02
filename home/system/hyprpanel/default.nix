{ pkgs, inputs, ... }: {
  imports = [
    inputs.hyprpanel.homeManagerModules.hyprpanel
    inputs.ags.homeManagerModules.default
  ];
  home.packages = with pkgs; [
    power-profiles-daemon
    pavucontrol
    pulseaudio
    brightnessctl
    btop
  ];
  programs.ags = {
    enable = true;
  };
  programs.hyprpanel = {
    enable = true;
    overlay.enable = true;
    overwrite.enable = true;
    hyprland.enable = true;
    
    settings = {
      theme = {
        name = "catppuccin_mocha";
        bar.floating = false;
        bar.buttons.enableBorders = true;
        bar.transparent = true;
        font.size = "14px";
        bar.buttons.modules.ram.enableBorder = false;
      };

      layout = {
      "bar.layouts" =
        let
          layout = { showBattery ? true }: {
            "left" = [
              "dashboard"
              "workspaces"
              "windowtitle"
              "storage"
            ] ++ (if showBattery then [ "battery" ] else [ ]);
            "middle" = [
              "media"
            ];
            "right" = [
              "cpu"
              "ram"
              "volume"
              "network"
              "bluetooth"
              "systray"
              "clock"
              "notifications"
            ];
          };
          none = {
            "left" = [ ];
            "middle" = [ ];
            "right" = [ ];
          };
        in
        {
          "0" = none;
          "1" = layout { };
          "2" = layout { showBattery = false; };
          "3" = none;
        };
    };
      bar.customModules.updates.pollingInterval = 1440000;
      menus.clock.time.military = true;
      menus.clock.time.hideSeconds = false;
      bar.clock.format = "%y/%m/%d  %H:%M";
      bar.media.show_active_only = true;
      bar.notifications.show_total = false;
      bar.launcher.autoDetectIcon = true;
      bar.battery.hideLabelWhenFull = true;
      menus.dashboard.controls.enabled = false;
      menus.dashboard.shortcuts.enabled = true;
      menus.clock.weather.enabled = false;
      menus.dashboard.shortcuts.right.shortcut1.command = "gcolor3";
      menus.media.displayTime = true;
      menus.power.lowBatteryNotification = true;
      bar.volume.rightClick = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
      bar.volume.middleClick = "pavucontrol";
      bar.media.format = "{title}";
    };
  };
}
