# Debug message to confirm loading
echo "Loading ATLAS bash configuration..."

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Enable color support
export TERM=xterm-256color
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Some useful aliases for embedded development
alias dmesg='dmesg --color=always'
alias mount='mount | column -t'
alias df='df -h'
alias free='free -h'

# Root-specific aliases
alias reboot='echo "Rebooting keychain..."; sync; reboot'
alias poweroff='echo "Shutting down keychain..."; sync; poweroff'

# Dangerous commands with confirmation
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# Set a colorful prompt
PS1='\[\e[38;5;176m\]\u\[\e[0;2m\]@\[\e[0;38;5;115m\]\H\[\e[0m\] \[\e[2m\]\w\[\e[0;1m\] >\[\e[0m\] '

echo -e "  \x1b[1;4mTips and tricks:\x1b[0m"
echo "- If colors show up as blinking, try using tio instead of minicom."
echo "- You have vi and nano installed for editing files."
echo "- Run 'cat README.txt' to see further information about this system." 
echo "- If your terminal gets weird, try resetting it with 'reset' command."
