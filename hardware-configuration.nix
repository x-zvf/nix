{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "thunderbolt" "usb_storage" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = ["zfs"];
  boot.kernelModules = ["kvm-amd"];
  boot.kernelParams = ["nohibernate"];
  boot.extraModulePackages = [];
  boot.loader.grub = {
    enable = true;
    zfsSupport = true;
    efiSupport = true;
    mirroredBoots = [
      {
        devices = ["nodev"];
        path = "/boot";
      }
    ];
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
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices = [];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eth0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  systemd.network.enable = true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.amdgpu.opencl.enable = true;
}
