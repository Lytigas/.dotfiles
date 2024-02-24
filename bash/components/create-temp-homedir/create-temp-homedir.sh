# At runtime, create the temp homedir if it doesn't exist
if [ ! -e "$HOME/tmp" ] ; then
    ln -s -f "$(mktemp -d)" "$HOME/tmp"
fi
