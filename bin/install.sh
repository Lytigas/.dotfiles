#!/usr/bin/env bash
set -e

# might want things installed just for the user, but not as a tracked script
# ask_make_link "$DOTFILE_ROOT/no_target/bin" "$HOME/bin"
find "$DOTFILE_ROOT/no_target/bin" -type f | xargs chmod +x
