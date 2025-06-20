{ config, lib, pkgs, ... }:
with lib;
{
  options.niri = {
    monitors = mkOption {
      type = types.listOf types.str;
      default = ["eDP-1,1920x1080@60,0x0,1"];
      example = ["DP-1,2560x1440@144,0x0,1" "HDMI-A-1,1920x1080@60,2560x0,1"];
      description = "Monitor configurations in format: name,resolution@rate,position,scale";
    };
    input = {
      sensitivity = mkOption {
        type = types.float;
        default = 0.0;
        description = "Mouse sensitivity";
      };
      kb_layout = mkOption {
        type = types.str;
        default = "us";
        description = "Keyboard layout";
      };
    };
  };

  config = {
    home.file.".config/niri/niri.kdl".text = let
      # Parse monitor strings into KDL output blocks
      parseMonitor = monStr: let
        parts = lib.splitString "," monStr;
        name = lib.elemAt parts 0;
        resolution = lib.elemAt parts 1;
        position = lib.elemAt parts 2;
        scale = if lib.length parts > 3 then lib.elemAt parts 3 else "1";
        positionParts = lib.splitString "x" position;
      in ''
        output "${name}" {
          mode "${resolution}"
          position x=${lib.elemAt positionParts 0} y=${lib.elemAt positionParts 1}
          scale ${scale}
        }'';
      
      monitorConfigs = concatStringsSep "\n" (map parseMonitor config.niri.monitors);
      baseConfig = builtins.readFile ./niri.kdl;
    in ''
      ${baseConfig}

      // Generated configuration from options
      // Input configuration  
      input {
        keyboard {
          xkb {
            layout "${config.niri.input.kb_layout}"
          }
        }
        mouse {
          accel-speed ${toString config.niri.input.sensitivity}
          accel-profile "flat"
        }
      }

      // Output configuration
      ${monitorConfigs}
    '';
  };
}