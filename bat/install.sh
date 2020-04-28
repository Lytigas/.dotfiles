#!/usr/bin/env bash

set -e

bat <<< "Verifying bat install"

DOTFILE_THEME_DIR="lytigas-dotfile-themes"

mkdir -p "$(bat --config-dir)/themes/$DOTFILE_THEME_DIR"

ask_make_link "$PWD/config" "$(bat --config-dir)/config"
# bat doesn't like to follow symlinks, so we have to copy
cp -R "$PWD/themes/" "$(bat --config-dir)/themes/$DOTFILE_THEME_DIR"

bat cache --build
