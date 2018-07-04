#!/usr/bin/env bash

set -ea

source ./include.sh

cd "$DOTFILE_ROOT"

if [ "$#" -lt 1 ]; then
	echo "Provide at least one target"
	exit
fi

if [ "$1" = "all" ]; then
	for target in $(ls -1 -d -- */)
	do
		install_target "$target"
	done
	exit
fi

while (( "$#" )); do
	install_target "$1"
	shift
done
