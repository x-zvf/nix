{
  pkgs,
  lib,
  ...
}:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.optimise.automatic = true;
  imports = [
    ./hardware-configuration.nix
    ./modules/pkgsets/system-packages.nix
    ./modules/steam.nix
    ./modules/cron.nix
  ];

  boot = {
    loader.efi.canTouchEfiVariables = true;

    kernelParams = [
      "rd.luks.options=discard"
      #"amd_iommu=off" # VP9 video decode bug - still happening
      #"amdgpu.sg_display=0"
    ];
    kernel.sysctl."kernel.sysrq" = 1;
  };

  documentation = {
    dev.enable = true;
    man = {
      enable = true;
      generateCaches = true;
    };
  };

  programs = {
    virt-manager.enable = true;
    java.enable = true;
    dconf.enable = true;
    mtr.enable = true;
    light.enable = true;
    kdeconnect.enable = true;
    nix-ld.enable = true;
  };

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

  networking = {
    hostName = "rubidium";
    hostId = "7de56727";
    networkmanager.enable = true;
  };

  systemd.extraConfig = ''
    DefaultTimeoutStopSec=5s
  '';

  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.services.systemd-networkd-wait-online.enable = lib.mkForce false;
  networking.firewall.enable = false;

  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.resolved.enable = true;
  services.udev.packages = [
    pkgs.platformio-core
    pkgs.openocd
  ];

  services.gvfs.enable = true;
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "nixshare";
        "netbios name" = "nixshare";
        "security" = "user";
      };
      "share" = {
        "path" = "/home/xzvf/VMs/shared";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "xzvf";
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  #NOTE: one must use zerotier-systemd-manager to get dns to work
  #NOTE: manual approval in my.zerotier.com required - hence this netwokid can
  #      be in public
  services.zerotierone = {
    enable = true;
    joinNetworks = [ "272f5eae16696d44" ];
    #generateSystemdNetworkdConfig = true;
  };

  time.timeZone = "Europe/Berlin";
  console.keyMap = "uk";
  i18n.defaultLocale = "en_GB.UTF-8";

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "gb";
        variant = "";
      };
    };
    displayManager = {
      autoLogin = {
        enable = true;
        user = "xzvf";
      };
      defaultSession = "sway";
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
    desktopManager.plasma6.enable = true;
  };
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  /*
       services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = ''
            export XDG_SESSION_TYPE=wayland
            export XDG_SESSION_DESKTOP=sway
            export XDG_CURRENT_DESKTOP=sway

            # Wayland stuff
            export QT_QPA_PLATFORM=wayland
            export SDL_VIDEODRIVER=wayland
            export _JAVA_AWT_WM_NONREPARENTING=1
            export NIXOS
            ${pkgs.sway}/bin/sway -c /home/xzvf/nix/home/sway/sway.conf
          '';
          user = "xzvf";
        };
        default_session = initial_session;
      };
    };
  */
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
    after = [
      "network.target"
      "sound.target"
    ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  services.pulseaudio.enable = false;
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
    interval = "hourly";
  };

  services.printing.enable = true;
  security = {
    rtkit.enable = true;
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
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
    initialPassword = "changeme";
    description = "Péter Bohner";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "networkmanager"
      "docker"
      "video"
    ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
    permittedInsecurePackages = [
      "openssl-1.1.1w" # sublime4
    ];
  };
  system.stateVersion = "25.05";
}
