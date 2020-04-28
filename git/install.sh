#!/usr/bin/env bash

set -e

# ensure delta is installed
delta < /dev/null > /dev/null

ask_make_link "$PWD/gitconfig" "$HOME/.gitconfig"
