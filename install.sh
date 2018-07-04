#!/usr/bin/env bash

set -ea

DOTFILES_DIR="$PWD"
INST_SCRIPT="install.sh"

source ./include.sh

function install_target() {
	if [[ "$1" =~ "no_target" ]]; then
		return
	fi
	if [ ! -d "$1" ]; then
		echo "Could not find directory '$1', skipping."
		return
	fi
	if [ ! -f "$1/$INST_SCRIPT" ]; then
		echo "Could not run '$1/$INST_SCRIPT', file not found."
		return
	fi
	echo "Running install.sh for $1"
	cd "$1" && chmod +x "$INST_SCRIPT" && ./$INST_SCRIPT
}
# export for xargs
export -f install_target

# Change to the dir of this script
cd "${0%/*}"

if [ "$#" -lt 1 ]; then
	echo "Provide at least one target"
	exit
fi

if [ "$1" = "all" ]; then
	for target in $(ls -d -- */)
	do
		install_target "$target"
	done
	exit
fi

while (( "$#" )); do
	install_target "$1"
	shift
done
