{ pkgs, lib, ... }:
{
    systemd.user.services.easyeffects = {
    Unit = {
      Description = "Easyeffects daemon";
      After = [ "graphical-session.target" "pipewire.service" "pipewire-pulse.service" ];
      Requires = [ "pipewire.service" ];
    };

    Service = {
      Type = lib.mkForce "simple";
      ExecStart = "${pkgs.easyeffects}/bin/easyeffects --gapplication-service --load-preset microphone-filter";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  services.easyeffects = {
    enable = true;
    preset = "microphone-filter";
    extraPresets = {
      "microphone-filter" = {
        input = {
          blocklist = [];

          # Noise suppression
          "rnnoise#0" = {
            bypass = false;
            "enable-vad" = false;
            "input-gain" = 0.0;
            "model-path" = "";
            "output-gain" = 0.0;
            release = 20.0;
            "vad-thres" = 50.0;
            wet = 0.0;
          };

          # Noise gate - optimized for close-mic male voice
          "gate#0" = {
            attack = 5.0;
            bypass = false;
            "curve-threshold" = -38.0;
            "curve-zone" = -3.0;
            dry = -100.0;
            "hpf-frequency" = 80.0;
            "hpf-mode" = "Butterworth";
            hysteresis = true;
            "hysteresis-threshold" = -6.0;
            "hysteresis-zone" = -2.0;
            "input-gain" = 0.0;
            "lpf-frequency" = 20000.0;
            "lpf-mode" = "off";
            makeup = 0.0;
            "output-gain" = 0.0;
            reduction = -20.0;
            release = 120.0;
            sidechain = {
              input = "Internal";
              lookahead = 0.0;
              mode = "RMS";
              preamp = 0.0;
              reactivity = 10.0;
              source = "Middle";
              "stereo-split-source" = "Left/Right";
            };
            "stereo-split" = false;
            wet = 0.0;
          };

          # De‑esser - tuned for male sibilance
          "deesser#0" = {
            bypass = false;
            detection = "RMS";
            "f1-freq" = 5000.0;
            "f1-level" = -3.0;
            "f2-freq" = 7000.0;
            "f2-level" = -3.0;
            "f2-q" = 1.8;
            "input-gain" = 0.0;
            laxity = 12;
            makeup = 0.0;
            mode = "Wide";
            "output-gain" = 0.0;
            ratio = 3.5;
            "sc-listen" = false;
            threshold = -20.0;
          };

          # Compressor - optimized for streaming voice
          "compressor#0" = {
            attack = 4.0;
            "boost-amount" = 0.0;
            "boost-threshold" = -72.0;
            bypass = false;
            dry = -100.0;
            "hpf-frequency" = 80.0;
            "hpf-mode" = "Butterworth";
            "input-gain" = 0.0;
            knee = 6.0;
            "lpf-frequency" = 20000.0;
            "lpf-mode" = "off";
            makeup = 4.0;
            mode = "Downward";
            "output-gain" = 0.0;
            ratio = 3.0;
            release = 100.0;
            "release-threshold" = -40.0;
            sidechain = {
              lookahead = 3.0;
              mode = "RMS";
              preamp = 0.0;
              reactivity = 8.0;
              source = "Middle";
              "stereo-split-source" = "Left/Right";
              type = "Feed-forward";
            };
            "stereo-split" = false;
            threshold = -20.0;
            wet = 0.0;
          };

          # Equalizer - with high-pass filter as first band
          "equalizer#0" = {
            balance = 0.0;
            bypass = false;
            "input-gain" = 0.0;
            left = {
              # High-pass filter (80Hz rolloff)
              band0 = {
                frequency = 80.0;
                gain = -12.0;  # Steep cut for high-pass effect
                mode = "BWC (MT)";
                mute = false;
                q = 0.7;       # Lower Q for broader cut
                slope = "x2";
                solo = false;
                type = "High-pass";  # This is the key - use High-pass type
                width = 4.0;
              };
              # Rest of EQ bands...
              band1 = {
                frequency = 120.0;
                gain = 2.0;
                mode = "RLC (MT)";
                mute = false;
                q = 0.7;
                slope = "x1";
                solo = false;
                type = "Lo-shelf";
                width = 4.0;
              };
              band2 = {
                frequency = 250.0;
                gain = -1.5;
                mode = "BWC (MT)";
                mute = false;
                q = 1.2;
                slope = "x2";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band3 = {
                frequency = 2000.0;
                gain = 2.0;
                mode = "BWC (BT)";
                mute = false;
                q = 1.0;
                slope = "x2";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band4 = {
                frequency = 4000.0;
                gain = 1.5;
                mode = "BWC (BT)";
                mute = false;
                q = 1.5;
                slope = "x2";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band5 = {
                frequency = 10000.0;
                gain = 1.5;
                mode = "LRX (MT)";
                mute = false;
                q = 0.7;
                slope = "x1";
                solo = false;
                type = "Hi-shelf";
                width = 4.0;
              };
            };
            mode = "IIR";
            "num-bands" = 6;
            "output-gain" = 0.0;
            "pitch-left" = 0.0;
            "pitch-right" = 0.0;
            right = {
              band0 = {
                frequency = 80.0;
                gain = -12.0;
                mode = "BWC (MT)";
                mute = false;
                q = 0.7;
                slope = "x2";
                solo = false;
                type = "High-pass";
                width = 4.0;
              };
              band1 = {
                frequency = 120.0;
                gain = 2.0;
                mode = "RLC (MT)";
                mute = false;
                q = 0.7;
                slope = "x1";
                solo = false;
                type = "Lo-shelf";
                width = 4.0;
              };
              band2 = {
                frequency = 250.0;
                gain = -1.5;
                mode = "BWC (MT)";
                mute = false;
                q = 1.2;
                slope = "x2";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band3 = {
                frequency = 2000.0;
                gain = 2.0;
                mode = "BWC (BT)";
                mute = false;
                q = 1.0;
                slope = "x2";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band4 = {
                frequency = 4000.0;
                gain = 1.5;
                mode = "BWC (BT)";
                mute = false;
                q = 1.5;
                slope = "x2";
                solo = false;
                type = "Bell";
                width = 4.0;
              };
              band5 = {
                frequency = 10000.0;
                gain = 1.5;
                mode = "LRX (MT)";
                mute = false;
                q = 0.7;
                slope = "x1";
                solo = false;
                type = "Hi-shelf";
                width = 4.0;
              };
            };
            "split-channels" = false;
          };

          # Limiter
          "limiter#0" = {
            alr = false;
            "alr-attack" = 5.0;
            "alr-knee" = 0.0;
            "alr-release" = 50.0;
            attack = 1.0;
            bypass = false;
            dithering = "16bit";
            "external-sidechain" = false;
            "gain-boost" = true;
            "input-gain" = 0.0;
            lookahead = 5.0;
            mode = "Herm Wide";
            "output-gain" = 0.0;
            oversampling = "Half x2(2L)";
            release = 10.0;
            "sidechain-preamp" = 0.0;
            "stereo-link" = 100.0;
            threshold = -6.0;
          };

          plugins_order = [
            "rnnoise#0"
            "gate#0"
            "deesser#0"
            "compressor#0"
            "equalizer#0"  # High-pass is handled here as first EQ band
            "limiter#0"
          ];
        };
      };
    };
  };
}