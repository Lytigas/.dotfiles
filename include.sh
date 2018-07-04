#!/usr/bin/env bash

export DOTFILE_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export INST_SCRIPT="install.sh"

install_target() {
	if [[ "$1" =~ "no_target" ]]; then
		return
	fi
	if [[ ! -d "${1}" ]]; then
		echo "Could not find directory '$1', skipping."
		return
	fi
	if [ ! -f "$1/$INST_SCRIPT" ]; then
		echo "Could not run '$1/$INST_SCRIPT', file not found."
		return
	fi
	echo "Running install.sh for $1"
	current_dir="$PWD"
	cd "$1" && chmod +x "$INST_SCRIPT" && ./$INST_SCRIPT
	cd "$current_dir"
}
export -f install_target

ask_make_link() {
	if [ -a "$2" ]; then
		read -p "File '$2' exists, overwrite with symlink to '$1' ([y]/n)? " answer
		[ -z "$answer" ] && answer="Yes"
		case ${answer:0:1} in
    			y|Y )
    			;;
    			* )
        			echo "Skipping"
				return
    			;;
		esac
	fi
	ln --force --symbolic -T "$1" "$2"
	echo "Symlinked '$2' to '$1'"
}
export -f ask_make_link
