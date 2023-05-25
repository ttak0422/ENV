
> **Warning**
> → ENV will be archived. (refined new dotfiles → [eden](https://github.com/ttak0422/eden))

<div align="center">
<h1>ENV</h1>
<p align="center">
<a href="https://nixos.org">
<img src="https://img.shields.io/badge/channel-unstable-white?style=flat&logo=NixOS&logoColor">
</a>
<img alt="license" src="https://img.shields.io/github/license/ttak0422/ENV">
</p>

<img width="1800" alt="image" src="https://user-images.githubusercontent.com/15827817/220372689-fb0e4c6c-639c-4ed8-ab10-4a40b590dc1e.png">


</div>


## Setup

### Darwin

```
# build
$ nix --experimental-features 'nix-command flakes' build .#darwinConfigurations.darwinM1.system

# delete nix.conf (first time only)
sudo rm /etc/nix/nix.conf

# switch (first time only)
$ ./result/sw/bin/darwin-rebuild switch --flake .#darwinM1
# switch
$ darwin-rebuild switch --flake .#darwinM1

# switch (if contains submodules)
# darwin-rebuild switch --flake '.?submodules=true#darwinM1'
```

<img alt="nix" src="https://builtwithnix.org/badge.svg">
