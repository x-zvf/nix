{
  pkgs,
  lib,
  ...
}:
{
  networking.hostName = "rubidium";
  networking.hostId = "7de56727";

  imports = [
    ../modules/nix.nix
    ../modules/defaults.nix
    ../modules/backup.nix

    ../modules/pkgsets/system-packages.nix
    ../modules/pkgsets/system-devel.nix

    ../modules/virtualization.nix
    ../modules/networking.nix
    ../modules/samba.nix
    ../modules/cron.nix
    ../modules/bluetooth.nix

    ../modules/users/xzvf.nix
    ../modules/desktop.nix
    ../modules/audio.nix
    ../modules/steam.nix
  ];

  boot = {
    loader.efi.canTouchEfiVariables = true;
    kernel.sysctl."kernel.sysrq" = 1;
    initrd = {
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "thunderbolt"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      kernelModules = [ "zfs" ];
    };
    kernelModules = [ "kvm-amd" ];

    kernelParams = [ "nohibernate" ];

    extraModulePackages = [ ];

    loader.grub = {
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
  };

  services = {
    fwupd.enable = true;
    fprintd.enable = true;
    power-profiles-daemon.enable = true;
    hardware.bolt.enable = true;
  };
  hardware = {
    sensor.iio.enable = true;
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true;
    amdgpu.opencl.enable = true;
  };

  systemd.services.disableInterrupt = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    description = "Disable GPE 10 interrupt";
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      ExecStart = ''/bin/sh -c 'echo "enable" > /sys/firmware/acpi/interrupts/gpe10; echo "disable" > /sys/firmware/acpi/interrupts/gpe10' '';
      RemainAfterExit = true;
    };
  };

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

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = "25.05";

}
