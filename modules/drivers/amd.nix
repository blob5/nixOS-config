{ ... }:

{
  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.enableRedistributableFirmware = true;

  boot.initrd.kernelModules = [ "amdgpu" ];

  boot.kernelParams = [
    "amdgpu.dc=1"
  ];
}
