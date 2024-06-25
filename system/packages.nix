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
    man-pages
    man-pages-posix
    neovim
    perf-tools
    linuxPackages_latest.perf
    rsync
    tmux
    unzip
    wget
    wireguard-tools
    virtiofsd
    zsh

    linuxPackages_latest.systemtap

    # fix input-leap
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
  ];
}
