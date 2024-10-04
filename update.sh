#!/usr/bin/env bash
set -xe

cd "$(dirname "$0")"
nix flake update
#home-manager --flake '/home/xzvf/nix#xzvf' switch
sudo nixos-rebuild --flake '/home/xzvf/nix#default' switch
git add ./flake.lock
git commit -m "update flake"
