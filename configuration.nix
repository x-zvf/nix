{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
     neovim
     wget
     git
     gcc
     zsh
     stow
     htop
     btop
     ripgrep
     ripgrep-all
     rsync
     easyeffects
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "rubidium"; # Define your hostname.
  networking.networkmanager.enable = true;
  
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.resolved.enable = true;

  time.timeZone = "Europe/Berlin";

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

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };
  console.keyMap = "uk";

  services.printing.enable = true;
  hardware.bluetooth.enable = true;

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

  services.fprintd.enable = true;

  programs.zsh.enable = true;

  users.users.xzvf = {
    isNormalUser = true;
    description = "xzvf";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "dialout" "networkmanager" ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "xzvf" = import ./home.nix;
    };
  };

  nixpkgs.config.allowUnfree = true;


  programs.mtr.enable = true;
  programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
  };

  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 * * * *      xzvf    . /etc/profile; pferd"
    ];
  };


  networking.firewall.enable = false;
  system.stateVersion = "24.05";
}
