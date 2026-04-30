{ ... }:

{
  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    extraConfig.pipewire = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 128;
        "default.clock.min-quantum" = 64;
        "default.clock.max-quantum" = 256;
      };
    };

    extraConfig.pipewire-pulse = {
      "context.modules" = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = {
            "pulse.min.req" = "64/48000";
            "pulse.default.req" = "128/48000";
            "pulse.max.req" = "256/48000";
            "pulse.min.quantum" = "64/48000";
            "pulse.max.quantum" = "256/48000";
          };
        }
      ];

      "stream.properties" = {
        "node.latency" = "128/48000";
        "resample.quality" = 5;
        "session.suspend-timeout-seconds" = 5;
        "node.autoconnect" = true;
      };
    };
  };

}
