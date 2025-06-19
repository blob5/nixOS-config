# modules/desktop/compositors/hyprland/default.nix
{ config, lib, pkgs, ... }:
with lib;
{
  options.hyprland = {
    monitors = mkOption {
      type = types.listOf types.str;
      default = [];
      example = [ "DP-1,2560x1440@144,0x0,1" ];
    };
    
    input = {
      sensitivity = mkOption {
        type = types.float;
        default = 0.0;
      };
      kb_layout = mkOption {
        type = types.str;
        default = "us";
      };
    };
    
    accel_profile = mkOption {
      type = types.str;
      default = "flat";
    };
  };

  config = {
    # Include your common hyprland.conf content here
    home.file.".config/hypr/hyprland.conf".text = ''
      ${builtins.readFile ./hyprland.conf}
      
      # Generated from options
      ${concatStringsSep "\n" (map (m: "monitor=${m}") config.hyprland.monitors)}
      
      input {
        kb_layout = ${config.hyprland.input.kb_layout}
        sensitivity = ${toString config.hyprland.input.sensitivity}
        accel_profile = ${config.hyprland.accel_profile}
      }
    '';
  };
}