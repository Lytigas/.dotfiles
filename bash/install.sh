#!/usr/bin/env bash

source ../include.sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

include_comp() {
    echo "Running compose.sh for $2"
	current_dir="$PWD"

    echo "# === Component $2 ===" >> $1
	cd "$2" && chmod +x "compose.sh" && ./compose.sh >> $1
	echo "" >> $1

    cd "$current_dir"
}

bashrc="$DIR/bashrc.sh"
echo "# AUTO GENERATED ON $( date )." > $bashrc
echo "" >> $bashrc
profile="$DIR/profile.sh"
echo "# AUTO GENERATED ON $( date )." > $profile
echo "" >> $profile
cd components

# include components here, in order
include_comp $bashrc etc-bashrc
include_comp $bashrc local-bin
include_comp $bashrc cargo
include_comp $bashrc exit-non-interactive
include_comp $bashrc "history"
include_comp $bashrc "shopt"
include_comp $bashrc colors
include_comp $bashrc aliases
include_comp $bashrc completion
include_comp $bashrc gcc-colors
include_comp $bashrc lesspipe
include_comp $bashrc prompt

include_comp $profile include-bashrc
include_comp $profile cargo
include_comp $profile local-bin
include_comp $profile python-bin

cd ..

ask_make_link "$DIR/bashrc.sh" "$HOME/.bashrc"
ask_make_link "$DIR/profile.sh" "$HOME/.profile"
