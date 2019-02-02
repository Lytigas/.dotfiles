#!/usr/bin/env bash
set -e

# sources autojump script if it exists
if [ -f "/usr/share/autojump/autojump.sh" ]; then
    echo '# Found autojump init'
    echo 'source /usr/share/autojump/autojump.sh'
else
    echo "# autojump init file not found, skipping"
    echo '#'
fi
