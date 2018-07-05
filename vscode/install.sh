#!/usr/bin/env bash
set -e

# verify vscode is installed
command -v code || {
    echo "vscode not installed, skipping..."
    exit 1
}

echo "Installing vscode extensions..."

# html
code --install-extension formulahendry.auto-rename-tag
code --install-extension formulahendry.auto-close-tag
# md
code --install-extension DavidAnson.vscode-markdownlint
# general
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension robertohuertasm.vscode-icons

echo "Symlinking vscode configs"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ask_make_link "$DIR/settings.json" "$HOME/.config/Code/User/settings.json"
ask_make_link "$DIR/keybindings.json" "$HOME/.config/Code/User/keybindings.json"
