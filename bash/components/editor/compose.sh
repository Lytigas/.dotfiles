#!/usr/bin/env bash
set -e

if nvim --help >/dev/null 2>&1; then
    echo '# Found nvim in PATH'
    echo 'export EDITOR=nvim'
elif vim --help >/dev/null 2>&1; then
    echo '# Found vim in PATH'
    echo 'export EDITOR=vim'
else
    echo '# No editor override found installed, leaving default'
fi
