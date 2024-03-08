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
    #inputs.home-manager.nixosModules.default
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "rd.luks.options=discard"
  ];

  networking.hostName = "rubidium"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.resolved.enable = true;

  time.timeZone = "Europe/Berlin";
  console.keyMap = "uk";
  i18n.defaultLocale = "en_GB.UTF-8";
  #  i18n.extraLocaleSettings = {
  #    LC_ADDRESS = "de_DE.UTF-8";
  #    LC_IDENTIFICATION = "de_DE.UTF-8";
  #    LC_MEASUREMENT = "de_DE.UTF-8";
  #    LC_MONETARY = "de_DE.UTF-8";
  #    LC_NAME = "de_DE.UTF-8";
  #    LC_NUMERIC = "de_DE.UTF-8";
  #    LC_PAPER = "de_DE.UTF-8";
  #    LC_TELEPHONE = "de_DE.UTF-8";
  #    LC_TIME = "en_DK.UTF-8";
  #  };
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;

  hardware.enableAllFirmware = true;

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
    package = pkgs.mlocate;
    localuser = null;
    interval = "hourly";
  };

  services.hardware.bolt.enable = true;
  services.printing.enable = true;
  services.fprintd.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  # Framework 13 specific changes
  hardware.sensor.iio.enable = true;
  services.fwupd.enable = true;
  services.power-profiles-daemon.enable = true;

  programs.zsh.enable = true;
  users.users.xzvf = {
    isNormalUser = true;
    description = "Péter Bohner";
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel" "dialout" "networkmanager"];
  };
  #home-manager = {
  #  extraSpecialArgs = {inherit inputs;};
  #  users = {
  #    "xzvf" = import ./home.nix;
  #  };
  #};

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05";
}
