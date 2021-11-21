# ENV
my environment...


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