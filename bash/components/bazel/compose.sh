#!/usr/bin/env bash
set -e

# Adds cargo bin to the path if it exists
if [ -d "$HOME/.bazel" ]; then
    echo '# Found bazel completions'
    echo 'source "$HOME/.bazel/bin/bazel-complete.bash"'
else
    echo "# Bazel not found at $HOME/bin/bazel"
    echo '#'
fi
