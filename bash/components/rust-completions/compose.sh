#!/usr/bin/env bash
set -e

# Adds cargo bin to the path if it exists
# This also adds the rustup binary
if [ -d "$HOME/.cargo/bin" ]; then
    echo '# Found cargo, adding completions'
    echo 'eval "$(rustup completions bash rustup)"'
    echo 'eval "$(rustup completions bash cargo)"'
else
    echo "# Cargo not found at $HOME/.cargo/bin, skipping completions"
    echo '#'
    echo '#'
fi
