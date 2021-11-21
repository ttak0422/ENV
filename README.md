<h1 align="center">ENV</h1>
<p align="center">my environment...</p>

<p align="center">

<img alt="nix" src="https://builtwithnix.org/badge.svg">
<img alt="status" src="https://img.shields.io/github/workflow/status/ttak0422/ENV/CI?style=for-the-badge">
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
