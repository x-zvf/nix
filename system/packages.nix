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
    htop
    iotop
    neovim
    rsync
    tmux
    wget
    zsh
    home-manager
  ];
}
