#!/usr/bin/env bash
set -e

# verify vscode is installed
command -v code || exit 1

# icons
code --install-extension robertohuertasm.vscode-icons

# symlink settings
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ask_make_link "$DIR/settings.json" "$HOME/.config/Code/User/settings.json"
