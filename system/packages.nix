{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  environment.systemPackages = with pkgs; [
    btop
    gcc
    gdb
    git
    home-manager
    htop
    iotop
    killall
    man-pages
    man-pages-posix
    neovim
    perf-tools
    linuxPackages_latest.perf
    rsync
    tmux
    unzip
    p7zip
    wget
    wireguard-tools
    wl-clipboard
    virtiofsd
    zsh

    linuxPackages_latest.systemtap

    # fix input-leap
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
  ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
}
