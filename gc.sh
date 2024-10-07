#!/bin/sh

set -xe
sudo nixos-rebuild --flake '/home/xzvf/nix#default' switch
home-manager expire-generations 1second
sudo nix-collect-garbage -d
tree /nix/var/nix/gcroots
sudo fstrim -va
