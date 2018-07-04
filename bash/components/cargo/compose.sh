#!/usr/bin/env bash
set -e

# Adds cargo bin to the path if it exists
if [ -d "$HOME/.cargo/bin" ]; then
    echo '# Found cargo'
    echo 'PATH=~/.cargo/bin:$PATH'
else
    echo "# Cargo not found at $HOME/.cargo/bin"
    echo '#'
fi
