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

# Only do PATH/LD stuff here
include_comp $bashrc etc-bashrc
include_comp $bashrc local-bin
include_comp $bashrc cargo
include_comp $bashrc nvm
include_comp $bashrc frc2019
include_comp $bashrc bazel
# include_comp $profile python-bin

# https://unix.stackexchange.com/questions/257571/why-does-bashrc-check-whether-the-current-shell-is-interactive
include_comp $bashrc exit-non-interactive
include_comp $bashrc "history"
include_comp $bashrc "shopt"
include_comp $bashrc colors
include_comp $bashrc aliases
include_comp $bashrc completion
include_comp $bashrc gcc-colors
include_comp $bashrc lesspipe
include_comp $bashrc prompt
include_comp $bashrc autojump

# No custom behavior for login shells ATM, just defer to bashrc
include_comp $profile include-bashrc
include_comp $profile cargo
include_comp $profile frc2019
include_comp $profile nvm
include_comp $profile local-bin
include_comp $profile python-bin
include_comp $profile autojump

cd ..

ask_make_link "$DIR/bashrc.sh" "$HOME/.bashrc"
ask_make_link "$DIR/profile.sh" "$HOME/.profile"
