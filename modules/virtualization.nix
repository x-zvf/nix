{ pkgs, ... }:
{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
    };
    spiceUSBRedirection.enable = true;
    docker.enable = true;
    waydroid.enable = true;
    #vmware.host.enable = true;
    vmVariant = {
      virtualisation = {
        qemu.options = [ "-device virtio-vga" ];
        memorySize = 8192;
        cores = 4;
      };
    };
  };

  programs.virt-manager.enable = true;
}
