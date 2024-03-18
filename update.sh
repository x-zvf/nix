#!/bin/bin/env bash

cd "${BASH_SOURCE[0]}"

nix flake update
ga ./flake.lock
git commit -m "update flake"
home-manager --flake '/home/xzvf/nix#xzvf' switch
sudo nixos-rebuild switch --flake '/home/xzvf/nix#default'
