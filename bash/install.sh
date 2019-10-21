#!/usr/bin/env bash

set -e

source ../include.sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

include_comp() {
    echo "Running compose.sh for $2"
	current_dir="$PWD"

    echo "# === Component $2 ===" >> $1
	cd "$2" && chmod +x "compose.sh" && ./compose.sh >> $1 &&
	echo "" >> $1 &&

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

# there are four cases, on two axis
# interactive and login

# login refers to shells executed on login, such as starting x, a TTY, or an ssh session
# this is opposed to subshells, as invoked by the `bash` command
# interactive is well, interactive.

# login, interactive: .profile is run (ex: starting an interactive ssh session)
# non-login, interactive: .bashrc is run (ex: `screen` or `tmux` subshell, opening a new terminal)
# login, non-interactive: I don't know of any at the moment
# non-login, non-interactive: .bashrc is run (ex: running an `ssh [command]`, running `scp`)

# also note: .bashrc CANNOT print to stdout, this will break scp/rcp/sftp

# sources
# https://unix.stackexchange.com/questions/50665/what-is-the-difference-between-interactive-shells-login-shells-non-login-shell
# https://serverfault.com/questions/261802/what-are-the-functional-differences-between-profile-bash-profile-and-bashrc
# https://unix.stackexchange.com/questions/257571/why-does-bashrc-check-whether-the-current-shell-is-interactive

# Thus, to avoid double-setting env vars, we can only do it once.
# But have it set for remote commands, we need to do it from $bashrc, not $profile
# so we have a special component that caches whether env vars have been run, and runs it again if needed

include_comp $profile include-bashrc

echo "# Once-set env var components" >> $bashrc
echo "export ENV_VAR_BEEN_SET_SENTINEL='$(date)'" >> $bashrc
echo 'if [ "$ENV_VAR_SET_VALUE" != "$ENV_VAR_BEEN_SET_SENTINEL" ]; then' >> $bashrc
echo '' >> $bashrc
echo 'export ENV_VAR_SET_VALUE="$ENV_VAR_BEEN_SET_SENTINEL"' >> $bashrc
echo '' >> $bashrc

include_comp $bashrc frc2019
include_comp $bashrc nvm
include_comp $bashrc local-bin
include_comp $bashrc python-bin
include_comp $bashrc autojump
include_comp $bashrc rust-path
include_comp $bashrc bazel

echo '' >> $bashrc
echo 'fi # end once-set env vars' >> $bashrc
echo '' >> $bashrc

include_comp $bashrc etc-bashrc

# At this point, we're done with things relevant to non-interactive use
include_comp $bashrc exit-non-interactive
include_comp $bashrc lesspipe
include_comp $bashrc "history"
include_comp $bashrc "shopt"
include_comp $bashrc colors
include_comp $bashrc aliases
include_comp $bashrc completion
include_comp $bashrc rust-completions
include_comp $bashrc gcc-colors
include_comp $bashrc prompt

cd ..

ask_make_link "$DIR/bashrc.sh" "$HOME/.bashrc"
ask_make_link "$DIR/profile.sh" "$HOME/.profile"
