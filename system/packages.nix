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
  ];
}
