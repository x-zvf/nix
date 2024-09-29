{
  pkgs,
  inputs,
  ...
}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.optimise.automatic = true;
  imports = [
    ./hardware-configuration.nix
    ./system/packages.nix
    ./system/cron.nix
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
    "rd.luks.options=discard"
    "amd_iommu=off" # VP9 video decode bug - still happening
    #"amdgpu.sg_display=0"
    ];
    kernel.sysctl."kernel.sysrq" = 1;
  };

  documentation = {
    dev.enable = true;
    man = {
      man-db.enable = false;
      mandoc.enable = true;
      generateCaches = true;
    };
  };

  programs = {
    virt-manager.enable = true;
    java.enable = true;
    dconf.enable = true;
    mtr.enable = true;
    light.enable = true;
  };

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
    docker.enable = true;
    waydroid.enable = true;
  };

  networking.hostName = "rubidium"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.resolved.enable = true;
  services.udev.packages = [ 
    pkgs.platformio-core
    pkgs.openocd
  ];

  time.timeZone = "Europe/Berlin";
  console.keyMap = "uk";
  i18n.defaultLocale = "en_GB.UTF-8";

  # KDE (sway configured by home-manager
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "gb";
        variant = "";
      };
    };
    displayManager.sessionPackages = [ pkgs.sway ];
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };
   hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = ["network.target" "sound.target"];
    wantedBy = ["default.target"];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };


  # misc
  services.locate = {
    enable = true;
    package = pkgs.plocate;
    localuser = null;
    interval = "hourly";
  };

  services.printing.enable = true;
  security = {
    pam.services.swaylock = {};
    rtkit.enable = true;
    polkit.enable = true;
  };


  hardware.enableAllFirmware = true;

  # Framework 13 specific changes
  hardware.sensor.iio.enable = true;
  
  services = {
    fwupd.enable = true;
    fprintd.enable = true;
    power-profiles-daemon.enable = true;
    hardware.bolt.enable = true;
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

  users.users.xzvf = {
    isNormalUser = true;
    description = "Péter Bohner";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    extraGroups = ["networkmanager" "wheel" "dialout" "networkmanager" "docker" "video"];
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05";
}
