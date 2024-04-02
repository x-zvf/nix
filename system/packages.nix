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
    rsync
    tmux
    unzip
    wget
    wireguard-tools
    zsh
  ];
}
