# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
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

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_DK.UTF-8";

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
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
    

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.xzvf = {
    isNormalUser = true;
    description = "xzvf";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "dialout" "networkmanager" ];
    packages = with pkgs; [ ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "xzvf" = import ./home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
  };

  # services.openssh.enable = true;
  networking.firewall.enable = false;
  system.stateVersion = "24.05";

}
