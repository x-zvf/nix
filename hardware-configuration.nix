{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/cd4ffaf5-9327-4f9e-92bd-1e8d80c70fca";
      fsType = "ext4";
      options = [ "noatime" "discard" ];
    };

  boot.initrd.luks.devices."luks-f2821f9a-3082-4fb9-afe4-fc359749b6a8".device = "/dev/disk/by-uuid/f2821f9a-3082-4fb9-afe4-fc359749b6a8";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/EF4E-A49B";
      fsType = "vfat";
      options = [ "noatime" "discard" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/93a6fe6e-9bf7-4ee1-9464-4592cdb529d3";
      fsType = "ext4";
      options = [ "noatime" "discard" ];
    };

  boot.initrd.luks.devices."luks-7490ea57-f875-4e9b-a096-ba9980df4fce".device = "/dev/disk/by-uuid/7490ea57-f875-4e9b-a096-ba9980df4fce";

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eth0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
