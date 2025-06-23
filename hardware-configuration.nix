{
  lib,
  pkgs,
  ...
}:
{
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "thunderbolt"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ "zfs" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.kernelParams = [ "nohibernate" ];
  boot.extraModulePackages = [ ];
  boot.loader.grub = {
    enable = true;
    zfsSupport = true;
    efiSupport = true;
    mirroredBoots = [
      {
        devices = [ "nodev" ];
        path = "/boot";
      }
    ];
  };

  environment.systemPackages = with pkgs; [
    zfs-autobackup
  ];

  services.cron.systemCronJobs = [
    "10 * * * *     root    . /etc/profile; zfs-autobackup -v --ssh-target gabackup --ssh-config /home/xzvf/.ssh/config togallium RustBucket/backups/rubidium"
  ];

  fileSystems."/" = {
    device = "zpool/root";
    fsType = "zfs";
  };

  fileSystems."/nix" = {
    device = "zpool/nix";
    fsType = "zfs";
  };

  fileSystems."/var" = {
    device = "zpool/var";
    fsType = "zfs";
  };

  fileSystems."/home" = {
    device = "zpool/home";
    fsType = "zfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F357-5947";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [ ];

  systemd.network.enable = true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableAllFirmware = true;

  hardware.amdgpu.opencl.enable = true;
}
