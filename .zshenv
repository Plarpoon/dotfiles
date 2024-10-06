# Load environment variables for Cargo
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

# PATH configuration
# Add npm global binaries to PATH
export PATH="$HOME/.npm-global/bin:$HOME/.npm/npm-global/bin:$PATH"

# Add custom scripts and tools to PATH
export PATH="$PATH:$HOME/Git/quickemu/quickget"
export PATH="$PATH:$HOME/LunarG/x86_64/bin"

# GPG configuration
export GPG_TTY=$(tty)

# Chrome executable path for Flatpak
export CHROME_EXECUTABLE="/var/lib/flatpak/app/com.google.Chrome/x86_64/stable/active/files/extra/chrome"

# Java (commented out, uncomment to use)
# export PATH="$PATH:/usr/java/jdk1.8.0_172/bin"

# Custom functions
[ -f "$HOME/.vpn" ] && source "$HOME/.vpn"
