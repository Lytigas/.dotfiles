# ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# up command
up() { cd $(eval printf '../'%.0s {1..$1}) && pwd; }
