{ pkgs, ... }:

{
  programs.dconf.enable = true;
  
  users.users.blob.extraGroups = [ "libvirtd" "kvm" "input" ];
  
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice 
    spice-gtk
    spice-protocol
    virtio-win
    win-spice
    adwaita-icon-theme
    qemu
    libguestfs
    looking-glass-client
  ];
  
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  virtualisation.vmware.host.enable = true;

  # Enable huge pages for better performance
  boot.kernel.sysctl = {
    "vm.nr_hugepages" = 1024;
  };
} 