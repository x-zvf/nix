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

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "rd.luks.options=discard"
    #"amd_iommu=off" # VP9 video decode bug
    #"amdgpu.sg_display=0"
  ];
  boot.kernel.sysctl."kernel.sysrq" = 1;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  #virtualisation.vmware.host.enable = true;
  /* virtualisation.vmware.host.package = (pkgs.vmware-workstation.overrideAttrs rec{
    src = pkgs.requireFile {
      name = "VMware-Workstation-Full-17.5.1-23298084.x86_64.bundle";
      hash = "sha256-qmC3zvKoes77z3x6UkLHsJ17kQrL1a/rxe9mF+UMdJY=";
      message = "VMware WS Full .bundle not found in store";
    };
    unpackPhase = let
      vmware-unpack-env = pkgs.buildFHSEnv rec {
        name = "vmware-unpack-env";
        targetPkgs = pkgs: [ pkgs.zlib ];
      };
    in ''
      ${vmware-unpack-env}/bin/vmware-unpack-env -c "sh ${src} --extract unpacked"
    '';
}); */
  virtualisation.docker.enable = true;

  networking.hostName = "rubidium"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.resolved.enable = true;

  time.timeZone = "Europe/Berlin";
  console.keyMap = "uk";
  i18n.defaultLocale = "en_GB.UTF-8";
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.dconf.enable = true;

  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;

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

  services.locate = {
    enable = true;
    package = pkgs.plocate;
    localuser = null;
    interval = "hourly";
  };

  services.hardware.bolt.enable = true;
  services.printing.enable = true;
  #services.fprintd.enable = true;
  #services.fprintd.package = pkgs.fprintd.overrideAttrs {
  #  mesonCheckFlags = [
  #    "--no-suite"
  #    "fprintd:TestPamFprintd"
  #  ];
  #};

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

  # Framework 13 specific changes
  hardware.sensor.iio.enable = true;
  services.fwupd.enable = true;
  services.power-profiles-daemon.enable = true;

  #programs.zsh.enable = true;
  users.users.xzvf = {
    isNormalUser = true;
    description = "Péter Bohner";
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    extraGroups = ["networkmanager" "wheel" "dialout" "networkmanager" "docker"];
  };

  programs.mtr.enable = true;
  #programs.gnupg.agent = {
  #  enable = true;
  #  enableSSHSupport = true;
  #};

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05";
}
