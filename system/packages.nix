{ config, lib, pkgs, modulesPath, ... }:

{
  environment.systemPackages = with pkgs; [
     neovim
     wget
     tmux
     git
     gcc
     zsh
     stow
     htop
     btop
     iotop
     ripgrep
     ripgrep-all
     rsync
     easyeffects
  ];
}
