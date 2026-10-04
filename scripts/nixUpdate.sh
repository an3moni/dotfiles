#!/usr/bin/env sh
echo "Starting nix update"
nix run home-manager -- switch --flake ./nix-config#roger
echo "Updated nix"
