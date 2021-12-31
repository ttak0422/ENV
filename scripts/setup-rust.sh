#! /usr/bin/env nix-shell
#! nix-shell -i bash

set -eEu

rustup toolchain install stable
rustup component add rls rust-analysis rust-src
