{
  lib,
  pkgs,
  userSettings,
  ...
}:

{
  programs.dconf.enable = true;

  users.users.${userSettings.username}.extraGroups = lib.mkAfter [
    "libvirtd"
    "kvm"
    "input"
    "video"
    "render"
  ];

  environment.systemPackages = with pkgs; [
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
    quickemu # quickly create optimized vms
  ];
  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      firewallBackend = "nftables";
      qemu = {
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  # Enable huge pages for better performance
  boot.kernel.sysctl = {
    "vm.nr_hugepages" = 1024;
  };
}
