#!/usr/bin/env bash
set -e

echo '# make less more friendly for non-text input files, see lesspipe(1)'
echo '[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"'
