{ config, lib, pkgs, modulesPath, ... }:

{
  environment.systemPackages = with pkgs; [
     btop
     gcc
     gdb
     git
     htop
     iotop
     neovim
     ripgrep
     ripgrep-all
     rsync
     stow
     tmux
     wget
     zsh
  ];
}
