{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
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
    nfs-utils
    zsh
    nushell

    bpftrace

    zerotier-systemd-manager

    # fix input-leap
    libsForQt5.qt5.qtwayland
    qt6.qtwayland

    fw-ectool
  ];
}
