{ ... }:

{
  hardware.graphics.enable = true; # Enable OpenGL support
  services.xserver.videoDrivers = [ "amdgpu" ]; # Use the AMDGPU driver
  hardware.enableRedistributableFirmware = true; # Ensure GPU firmware is available
}