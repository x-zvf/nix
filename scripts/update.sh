#!/usr/bin/env bash
set -xe

#cd "$(dirname "$0")"
cd /home/xzvf/nix
nix flake update
sudo nixos-rebuild --flake "/home/xzvf/nix#$(hostname)" switch
git add ./flake.lock
git commit -m "update flake"
