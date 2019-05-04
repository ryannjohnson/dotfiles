# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Show the directory in the prompt
PS1='$(whoami)@$(hostname):\w\$ '

# Alias for lynx with local settings
alias lynx='lynx -cfg=~/.lynx.cfg'

# For gpg-agent ssh authentication
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
export GPG_TTY=$(/usr/bin/tty)
gpgconf --launch gpg-agent
gpg-connect-agent updatestartuptty /bye > /dev/null 2>&1 # For yubikey pinentry
