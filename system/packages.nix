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
    wget
    wireguard-tools
    zsh
  ];
}
