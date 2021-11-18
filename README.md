# ENV
my environment...

```
# build
$ nix --experimental-features 'nix-command flakes' build .#darwin.m1.system

# switch
./result/sw/bin/darwin-rebuild switch --flake .#darwinM1
```