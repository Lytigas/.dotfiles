#!/usr/bin/env bash
set -e

# Source opam config if it exists

if [ -d "$HOME/.opam/opam-init" ]; then
    echo '# Found opam'
    echo '. $HOME/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true'
else
    echo "# opam init not found at $HOME/.opam/opam-init"
    echo '#'
fi
