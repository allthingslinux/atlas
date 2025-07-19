# ~/.profile - Root user profile

# Source system profile
if [ -f /etc/profile ]; then
    . /etc/profile
fi

# Source bashrc if running bash
if [ -n "$BASH_VERSION" ] && [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
