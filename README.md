<div align="center">
<h1>ENV</h1>
<p align="center">
<a href="https://nixos.org">
<img src="https://img.shields.io/badge/channel-unstable-white?style=flat&logo=NixOS&logoColor">
</a>
<img alt="license" src="https://img.shields.io/github/license/ttak0422/ENV">
</p>

## Setup

### Darwin

```
# build
$ nix --experimental-features 'nix-command flakes' build .#darwinConfigurations.darwinM1.system

# switch (first time only)
$ ./result/sw/bin/darwin-rebuild switch --flake .#darwinM1

# switch
$ darwin-rebuild switch --flake .#darwinM1
```

<img alt="nix" src="https://builtwithnix.org/badge.svg">
