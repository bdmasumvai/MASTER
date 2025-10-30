#!/bin/bash
clear

echo -e "\033[1;96m"
echo "╔══════════════════════════════════════╗"
echo "║           MASTER INSTALLER           ║"
echo "╚══════════════════════════════════════╝"
echo -e "\033[0m"

# Check if Termux
if [ ! -d "$PREFIX" ]; then
    echo -e "\033[1;91m[ERROR] This script only works in Termux\033[0m"
    exit 1
fi

# Function to install package
install_pkg() {
    echo -e "\033[1;93m[*] Installing $1...\033[0m"
    pkg install "$1" -y >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -e "\033[1;92m[✓] $1 installed successfully\033[0m"
    else
        echo -e "\033[1;91m[ERROR] Failed to install $1\033[0m"
    fi
}

# Update packages
echo -e "\033[1;93m[*] Updating packages...\033[0m"
pkg update -y && pkg upgrade -y

# Install essential packages
packages=("git" "python" "curl" "ncurses-utils" "jq" "figlet" "zsh")
for pkg_name in "${packages[@]}"; do
    if ! command -v "$pkg_name" &>/dev/null; then
        install_pkg "$pkg_name"
    fi
done

# Install pip packages
echo -e "\033[1;93m[*] Installing Python packages...\033[0m"
pip install lolcat requests

# Setup directories
echo -e "\033[1;93m[*] Setting up directories...\033[0m"
mkdir -p "$HOME/.termux"
mkdir -p "$HOME/.Master-Masum"

# Copy files
if [ -f "files/colors.properties" ]; then
    cp "files/colors.properties" "$HOME/.termux/"
    echo -e "\033[1;92m[✓] Colors configured\033[0m"
fi

if [ -f "files/font.ttf" ]; then
    cp "files/font.ttf" "$HOME/.termux/"
    echo -e "\033[1;92m[✓] Font installed\033[0m"
fi

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "\033[1;93m[*] Installing oh-my-zsh...\033[0m"
    git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
fi

# Setup zsh
if [ ! -f "$HOME/.zshrc" ]; then
    cp "files/.zshrc" "$HOME/.zshrc"
    echo -e "\033[1;92m[✓] ZSH configuration installed\033[0m"
fi

# Setup theme
if [ -f "files/.master.zsh-theme" ]; then
    mkdir -p "$HOME/.oh-my-zsh/themes"
    cp "files/.master.zsh-theme" "$HOME/.oh-my-zsh/themes/"
    echo -e "\033[1;92m[✓] Theme installed\033[0m"
fi

# Install chat command
if [ -f "files/chat.sh" ]; then
    cp "files/chat.sh" "$PREFIX/bin/chat"
    chmod +x "$PREFIX/bin/chat"
    echo -e "\033[1;92m[✓] Chat command installed\033[0m"
fi

# Change shell to zsh
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s zsh
    echo -e "\033[1;92m[✓] Default shell changed to ZSH\033[0m"
fi

# Reload termux settings
termux-reload-settings

echo -e "\033[1;96m"
echo "╔══════════════════════════════════════╗"
echo "║        INSTALLATION COMPLETE!        ║"
echo "╚══════════════════════════════════════╝"
echo -e "\033[0m"

echo -e "\033[1;92m[✓] MASTER Banner installed successfully!\033[0m"
echo -e "\033[1;93m[*] Please restart Termux or type 'exit' and reopen\033[0m"
echo -e "\033[1;93m[*] Commands available: chat, report, dev\033[0m"

sleep 3
