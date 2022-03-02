<div align="center">
<h1>ENV</h1>
<p>my environment...</p>
<p align="center">
<img alt="nix" src="https://builtwithnix.org/badge.svg">
<br>
<a href="https://nixos.org">
<img src="https://img.shields.io/badge/channel-unstable-white?style=flat&logo=NixOS&logoColor">
</a>
<img alt="status" src="https://img.shields.io/github/workflow/status/ttak0422/ENV/CI?style=flat">
<img alt="license" src="https://img.shields.io/github/license/ttak0422/ENV">
</p>
</div>

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
