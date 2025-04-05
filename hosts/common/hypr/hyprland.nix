{ config, lib, pkgs, ... }:

{
  # Common hyprland settings that apply to all hosts
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      # Source host-specific configurations
      source = ~/.config/hypr/monitors.conf
      source = ~/.config/hypr/input.conf

      # Common settings
      $terminal = wezterm
      $fileManager = dolphin
      $menu = rofi -show drun -show-icons

      # Environment variables
      env = XCURSOR_SIZE,24
      env = XCURSOR_THEME,Bibata-Modern-Classic
      env = ELECTRON_OZONE_PLATFORM_HINT,wayland

      # Window rules
      $&=override
      windowrulev2 = opacity 1 $&,class:^(zen-twilight)$

      # General settings
      general { 
          gaps_in = 2
          gaps_out = 5
          border_size = 2
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)
          resize_on_border = false 
          allow_tearing = false
          layout = dwindle
      }

      # Decoration
      decoration {
          rounding = 10
          active_opacity = 0.85
          inactive_opacity = 0.9
          blur {
              enabled = true
              size = 8
              passes = 2
              ignore_opacity = true
              vibrancy = 0.1696
          }
      }

      # Animations
      animations {
          enabled = true
          bezier = myBezier, 0.05, 0.9, 0.1, 1.05
          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      # Layouts
      dwindle {
          pseudotile = true
          preserve_split = true
      }

      master {
          new_status = master
      }

      # Misc
      misc { 
          force_default_wallpaper = 1
          disable_hyprland_logo = true
      }

      # Gestures
      gestures {
          workspace_swipe = true
      }

      # Keybindings
      $mainMod = SUPER

      bind = $mainMod SHIFT, F, togglefloating,
      bind = $mainMod, Q, exec, $terminal,
      bind = $mainMod, C, killactive,
      bind = $mainMod, M, exit,
      bind = $mainMod, E, exec, $fileManager
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, R, exec, $menu 
      bind = $mainMod, P, pseudo,
      bind = $mainMod, J, togglesplit,
      bind = $mainMod, F, fullscreen,
      bind = $mainMod, T, togglegroup,

      # Move focus
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d
      
      # Move tabs
      bind = $mainMod, Tab, changegroupactive, r
      bind = $mainMod SHIFT, Tab, changegroupactive, l

      # Workspace switching
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move windows to workspaces
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Scroll through workspaces
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Screenshot
      bind = $mainMod SHIFT, S, exec, hyprshot -m region --clipboard-only
    '';
  };

  # Create symlinks for configurations
  home.activation.hyprlandConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # Create config directory if it doesn't exist
    mkdir -p ~/.config/hypr
    
    # Symlink the monitor configuration
    ln -sf ${./monitors.conf} ~/.config/hypr/monitors.conf
    
    # Symlink the input configuration
    ln -sf ${./input.conf} ~/.config/hypr/input.conf
  '';
} 