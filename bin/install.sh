#!/usr/bin/env bash
set -e

ask_make_link "$DOTFILE_ROOT/no_target/bin" "$HOME/bin"
find "$DOTFILE_ROOT/no_target/bin" -type f | xargs chmod +x
