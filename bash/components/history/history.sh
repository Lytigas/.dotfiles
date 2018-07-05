# Save 5,000 lines of history in memory
HISTSIZE=5000
# Save 200,000 lines of history to disk (will have to grep ~/.bash_history for full listing)
HISTFILESIZE=200000
# Append to history instead of overwrite
shopt -s histappend
# Ignore redundant or space commands
HISTCONTROL=ignoreboth
# Ignore more
HISTIGNORE='ls:ll:ls -alh:pwd:clear:history'
# Set time format
HISTTIMEFORMAT='%F %T '
# Multiple commands on one line show up as a single line
shopt -s cmdhist
# Append new history lines, clear the history list, re-read the history list, print prompt.
# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
