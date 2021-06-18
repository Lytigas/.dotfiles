#!/usr/bin/env bash

export THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# this may not be the right plugin dir, but if it exists it probably is
cp "$THIS_DIR/FileMessenger.plugin.js" ~/.config/BetterDiscord/plugins/
