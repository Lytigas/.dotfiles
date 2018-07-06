#!/usr/bin/env bash
set -e

# verify vscode is installed
command -v code || {
    echo "vscode not installed, skipping..."
    exit 1
}

echo "Installing vscode extensions..."
cmd="code --install-extension"

# html
$cmd formulahendry.auto-rename-tag
$cmd formulahendry.auto-close-tag
# md
$cmd DavidAnson.vscode-markdownlint
# toml
$cmd bungcip.better-toml
# general
$cmd robertohuertasm.vscode-icons

echo "Symlinking vscode configs"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ask_make_link "$DIR/settings.json" "$HOME/.config/Code/User/settings.json"
ask_make_link "$DIR/keybindings.json" "$HOME/.config/Code/User/keybindings.json"
