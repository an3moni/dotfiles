#!/usr/bin/env
echo "Starting nix update"
nix run home-manager -- switch --flake ./nix-config
echo "Updated nix"
