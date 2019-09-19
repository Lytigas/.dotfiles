#!/usr/bin/env bash
set -e

# Adds cargo bin to the path if it exists
if [ -d "$HOME/.nvm" ]; then
    echo '# Found nvm'
    echo 'export NVM_DIR="$HOME/.nvm"'
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm'
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion'
else
    echo "# nvm not found at $HOME/.nvm"
    echo '#'
fi
