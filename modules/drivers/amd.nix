{ ... }:

{
  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.enableRedistributableFirmware = true;

  boot.initrd.kernelModules = [ "amdgpu" "zenpower" "msr" ];

  boot.kernelParams = [
    "amdgpu.dc=1"
  ];

  hardware.amdgpu.opencl.enable = true;

  environment.variables.AMD_VULKAN_ICD = "RADV";

  nixpkgs.config.rocmSupport = true;
}
