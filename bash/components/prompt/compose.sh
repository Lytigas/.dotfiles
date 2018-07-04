#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

git submodule update --init --recursive
echo '# Include liquidprompt'
echo "source $DIR/liquidprompt/liquidprompt"
