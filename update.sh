#!/usr/bin/env bash
set -xe

cd "$(dirname "$0")"
sudo echo "Caching sudo"
nix flake update
home-manager --flake '/home/xzvf/nix#xzvf' switch
sudo nixos-rebuild switch --flake '/home/xzvf/nix#default'
git add ./flake.lock
git commit -m "update flake"
