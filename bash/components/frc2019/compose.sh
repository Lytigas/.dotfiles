#!/usr/bin/env bash
set -e

# Adds arm-frc2019-gcc bin to the path if it exists
if [ -d "$HOME/frc2019/roborio/bin" ]; then
    echo '# Found frc2019 compiler'
    echo 'PATH=~/frc2019/roborio/bin:$PATH'
else
    echo "# frc2019 not found at $HOME/frc2019/roborio/bin"
    echo '#'
fi
