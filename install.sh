#!/bin/bash
clear

# BD color
r='\033[1;91m'
p='\033[1;95m'
y='\033[1;93m'
g='\033[1;92m'
n='\033[1;0m'
b='\033[1;94m'
c='\033[1;96m'

# BD Symbol
X='\033[1;92m[\033[1;00m⎯꯭̽𓆩\033[1;92m]\033[1;96m'
D='\033[1;92m[\033[1;00m〄\033[1;92m]\033[1;93m'
E='\033[1;92m[\033[1;00m×\033[1;92m]\033[1;91m'
A='\033[1;92m[\033[1;00m+\033[1;92m]\033[1;92m'
C='\033[1;92m[\033[1;00m</>\033[1;92m]\033[92m'
lm='\033[96m▱▱▱▱▱▱▱▱▱▱▱▱\033[0m〄\033[96m▱▱▱▱▱▱▱▱▱▱▱▱\033[1;00m'
dm='\033[93m▱▱▱▱▱▱▱▱▱▱▱▱\033[0m〄\033[93m▱▱▱▱▱▱▱▱▱▱▱▱\033[1;00m'

# BD icon
OS="\uf6a6"
HOST="\uf6c3"
KER="\uf83c"
UPT="\uf49b"
PKGS="\uf8d6"
SH="\ue7a2"
TERMINAL="\uf489"
CHIP="\uf2db"
CPUI="\ue266"
HOMES="\uf015"

MODEL=$(getprop ro.product.model 2>/dev/null || echo "Unknown")
VENDOR=$(getprop ro.product.manufacturer 2>/dev/null || echo "Unknown")
devicename="${VENDOR} ${MODEL}"
THRESHOLD=100
random_number=$(( RANDOM % 2 ))

exit_script() {
    clear
    echo
    echo
    echo -e ""
    echo -e "${c}              (\_/)"
    echo -e "              (${y}^_^${c})     ${A} ${g}Hey dear${c}"
    echo -e "             ⊂(___)づ  ⋅˚₊‧ ଳ ‧₊˚ ⋅"              
    echo -e "\n ${g}[${n}${KER}${g}] ${c}Exiting ${g}Master Banner \033[1;36m"
    echo
    cd "$HOME"
    rm -rf MASTER 2>/dev/null
    exit 0
}

trap exit_script SIGINT SIGTSTP

check_disk_usage() {
    local threshold=${1:-$THRESHOLD}
    local total_size used_size disk_usage

    if ! command -v df >/dev/null 2>&1; then
        echo -e "${E} ${r}df command not found${n}"
        return 1
    fi

    total_size=$(df -h "$HOME" 2>/dev/null | awk 'NR==2 {print $2}')
    used_size=$(df -h "$HOME" 2>/dev/null | awk 'NR==2 {print $3}')
    disk_usage=$(df "$HOME" 2>/dev/null | awk 'NR==2 {print $5}' | sed 's/%//g')

    if [ -z "$disk_usage" ]; then
        echo -e "${E} ${r}Failed to get disk usage${n}"
        return 1
    fi

    if [ "$disk_usage" -ge "$threshold" ]; then
        echo -e "${g}[${n}\uf0a0${g}] ${r}WARN: ${y}Disk Full ${g}${disk_usage}% ${c}| ${c}U${g}${used_size} ${c}of ${c}T${g}${total_size}"
    else
        echo -e "${y}Disk usage: ${g}${disk_usage}% ${c}| ${g}${used_size}"
    fi
}

sp() {
    IFS=''
    local sentence=$1
    local second=${2:-0.05}
    for (( i=0; i<${#sentence}; i++ )); do
        char="${sentence:$i:1}"
        echo -n "$char"
        sleep "$second"
    done
    echo
}

start() {
    clear
    local LIME='\e[38;5;154m'
    local CYAN='\e[36m'
    local BLINK='\e[5m'
    local NC='\e[0m'
    
    type_effect() {
        local text="$1"
        local delay=$2
        local term_width
        term_width=$(tput cols)
        local text_length=${#text}
        local padding=$(( (term_width - text_length) / 2 ))
        printf "%${padding}s" ""
        for ((i=0; i<${#text}; i++)); do
            printf "${LIME}${BLINK}${text:$i:1}${NC}"
            if (( RANDOM % 3 == 0 )); then
                printf "${CYAN} ${NC}"
                sleep 0.05
                printf "\b"
            fi
            sleep "$delay"
        done
        echo
    }
    
    echo
    echo
    echo
    type_effect "[ MASTER STARTED]" 0.04
    sleep 0.2
    type_effect "「HELLO DEAR USER I•M Masum-Vai 」" 0.08
    sleep 0.5
    type_effect "【MASTER WILL PROTECT YOU】" 0.08
    sleep 0.7
    type_effect "<GOODBYE>" 0.08
    sleep 0.2
    type_effect "[ENJOY OUR MASTER]" 0.08
    sleep 0.5
    type_effect "!...............¡" 0.08
    echo
    sleep 2
    clear 
}

mkdir -p "$HOME/.Master-Masum"

tr() {
    if ! command -v curl >/dev/null 2>&1; then
        echo -e "${A} ${y}Installing curl...${n}"
        pkg install curl -y >/dev/null 2>&1
    fi
    
    if ! command -v tput >/dev/null 2>&1; then
        echo -e "${A} ${y}Installing ncurses-utils...${n}"
        pkg install ncurses-utils -y >/dev/null 2>&1
    fi
}

help() {
    clear
    echo
    echo -e " ${p}■ \e[4m${g}Use Button\e[0m ${p}▪︎${n}"
    echo
    echo -e " ${y}Use Termux Extra key Button${n}"
    echo
    echo -e " UP          ↑"
    echo -e " DOWN        ↓"
    echo
    echo -e " ${g}Select option Click Enter button"
    echo
    echo -e " ${b}■ \e[4m${c}If you understand, click the Enter Button\e[0m ${b}▪︎${n}"
    read -r -p ""
}

spin() {
    local delay=0.40
    local spinner=('█■■■■' '■█■■■' '■■█■■' '■■■█■' '■■■■█')

    show_spinner() {
        local process_name="$1"
        local pid=$!
        local spin_index=0
        
        tput civis
        while ps -p "$pid" >/dev/null 2>&1; do
            echo -ne "\033[1;96m\r [+] Installing $process_name please wait \e[33m[\033[1;92m${spinner[$spin_index]}\033[1;93m]\033[0m   "
            spin_index=$(( (spin_index + 1) % ${#spinner[@]} ))
            sleep "$delay"
        done
        wait "$pid" 2>/dev/null
        tput cnorm
        echo -e "\r\033[K\e[1;93m [Done $process_name]\e[0m"
        echo
        sleep 1
    }

    echo -e "${A} ${y}Updating packages...${n}"
    apt update >/dev/null 2>&1
    apt upgrade -y >/dev/null 2>&1
    
    packages=("git" "python" "ncurses-utils" "jq" "figlet" "termux-api" "lsd" "zsh" "ruby" "exa")

    for package in "${packages[@]}"; do
        if ! command -v "$package" >/dev/null 2>&1 && ! dpkg -l 2>/dev/null | grep -q "^ii  $package "; then
            echo -e "${A} ${y}Installing $package...${n}"
            pkg install "$package" -y >/dev/null 2>&1 &
            show_spinner "$package"
        else
            echo -e "${D} ${g}$package already installed${n}"
        fi
    done

    if ! command -v lolcat >/dev/null 2>&1; then
        echo -e "${A} ${y}Installing lolcat...${n}"
        pip install lolcat >/dev/null 2>&1 &
        show_spinner "lolcat(pip)"
    fi
    
    # Fix file operations
    if [ -f "$HOME/MASTER/files/report" ] && [ ! -f "$HOME/.Master-Masum/report" ]; then
        mkdir -p "$HOME/.Master-Masum"
        cp "$HOME/MASTER/files/report" "$HOME/.Master-Masum/" &
        show_spinner "Master-report"
    fi
    
    if [ -f "$HOME/MASTER/files/chat.sh" ] && [ ! -f "$PREFIX/bin/chat" ]; then
        cp "$HOME/MASTER/files/chat.sh" "$PREFIX/bin/chat"
        chmod +x "$PREFIX/bin/chat" &
        show_spinner "chat"
    fi
    
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh" >/dev/null 2>&1 &
        show_spinner "oh-my-zsh"
    fi
    
    if [ -f "$PREFIX/etc/motd" ]; then
        rm -rf "$PREFIX/etc/motd" >/dev/null 2>&1
    fi
    
    if [ "$SHELL" != "$PREFIX/bin/zsh" ] && [ -f "$PREFIX/bin/zsh" ]; then
        chsh -s zsh >/dev/null 2>&1 &
        show_spinner "zsh-shell"
    fi
    
    if [ ! -f "$HOME/.zshrc" ] && [ -d "$HOME/.oh-my-zsh" ]; then
        cp "$HOME/.oh-my-zsh/templates/zshrc.zsh-template" "$HOME/.zshrc" &
        show_spinner "zshrc"
    fi
    
    if [ ! -d "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions" ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions \
        "$HOME/.oh-my-zsh/plugins/zsh-autosuggestions" >/dev/null 2>&1 &
        show_spinner "zsh-autosuggestions"
    fi
    
    if [ ! -d "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting" ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "$HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting" >/dev/null 2>&1 &
        show_spinner "zsh-syntax"
    fi
    
    if ! command -v lolcat >/dev/null 2>&1 && command -v gem >/dev/null 2>&1; then
        gem install lolcat >/dev/null 2>&1 &
        show_spinner "lolcat(gem)"
    fi
}

setup() {
    local ds="$HOME/.termux"
    mkdir -p "$ds"
    
    local dx="$ds/font.ttf"
    local masum="$ds/colors.properties"
    
    if [ ! -f "$dx" ] && [ -f "$HOME/MASTER/files/font.ttf" ]; then
        cp "$HOME/MASTER/files/font.ttf" "$ds/"
    fi

    if [ ! -f "$masum" ] && [ -f "$HOME/MASTER/files/colors.properties" ]; then
        cp "$HOME/MASTER/files/colors.properties" "$ds/"
    fi
    
    if [ -f "$HOME/MASTER/files/ASCII-Shadow.flf" ]; then
        mkdir -p "$PREFIX/share/figlet"
        cp "$HOME/MASTER/files/ASCII-Shadow.flf" "$PREFIX/share/figlet/"
    fi
    
    if [ -f "$HOME/MASTER/files/remove" ]; then
        cp "$HOME/MASTER/files/remove" "$PREFIX/bin/"
        chmod +x "$PREFIX/bin/remove"
    fi
    
    termux-reload-settings >/dev/null 2>&1
}

BDnetcheck() {
    clear
    echo
    echo -e "               ${g}╔═══════════════╗"
    echo -e "               ${g}║ ${n}</>  ${c}MASTER-X${g}  ║"
    echo -e "               ${g}╚═══════════════╝"
    echo -e "  ${g}╔════════════════════════════════════════════╗"
    echo -e "  ${g}║  ${C} ${y}Checking Your Internet Connection¡${g}  ║"
    echo -e "  ${g}╚════════════════════════════════════════════╝${n}"
    
    local max_attempts=5
    local attempt=1
    
    while [ $attempt -le $max_attempts ]; do
        if curl --silent --head --fail https://github.com >/dev/null 2>&1; then
            break
        else
            echo -e "              ${g}╔══════════════════╗"
            echo -e "              ${g}║${C} ${r}No Internet (Attempt $attempt/$max_attempts) ${g}║"
            echo -e "              ${g}╚══════════════════╝"
            sleep 2.5
            attempt=$((attempt + 1))
        fi
    done
    
    if [ $attempt -gt $max_attempts ]; then
        echo -e "${E} ${r}Failed to connect to internet after $max_attempts attempts${n}"
        exit 1
    fi
    
    clear
}

donotchange() {
    clear
    echo
    echo
    echo -e ""
    echo -e "${c}              (\_/)"
    echo -e "              (${y}^_^${c})     ${A} ${g}Hey dear${c}"
    echo -e "             ⊂(___)づ  ⋅˚₊‧ ଳ ‧₊˚ ⋅"
    echo
    echo -e " ${A} ${c}Please Enter Your ${g}Banner Name${c}"
    echo

    local name=""
    while true; do
        read -r -p "[+]──[Enter Your Name]────► " name
        echo

        if [[ ${#name} -ge 1 && ${#name} -le 8 ]]; then
            break
        else
            echo -e " ${E} ${r}Name must be between ${g}1 and 8${r} characters. ${y}Please try again.${c}"
            echo
        fi
    done

    local D1="$HOME/.termux"
    mkdir -p "$D1"
    
    local USERNAME_FILE="$D1/usernames.txt"
    local VERSION="$D1/dx.txt"
    local INPUT_FILE="$HOME/MASTER/files/.zshrc"
    local THEME_INPUT="$HOME/MASTER/files/.master.zsh-theme"
    local OUTPUT_ZSHRC="$HOME/.zshrc"
    local OUTPUT_THEME="$HOME/.oh-my-zsh/themes/master.zsh-theme"
    local TEMP_FILE
    TEMP_FILE=$(mktemp)

    if [ ! -f "$INPUT_FILE" ]; then
        echo -e "${E} ${r}Source file $INPUT_FILE not found${n}"
        return 1
    fi

    if sed "s/MASUM/$name/g" "$INPUT_FILE" > "$TEMP_FILE" &&
       [ -f "$THEME_INPUT" ] && sed "s/MASUM/$name/g" "$THEME_INPUT" > "$OUTPUT_THEME" &&
       echo "$name" > "$USERNAME_FILE" &&
       echo "version 1.5" > "$VERSION"; then
        
        mv "$TEMP_FILE" "$OUTPUT_ZSHRC"
        clear
        echo
        echo
        echo -e "		        ${g}Hey ${y}$name"
        echo -e "${c}              (\_/)"
        echo -e "              (${y}^ω^${c})     ${g}I'm Masum-Vai${c}"
        echo -e "             ⊂(___)づ  ⋅˚₊‧ ଳ ‧₊˚ ⋅"
        echo
        echo -e " ${A} ${c}Your Banner created ${g}Successfully¡${c}"
        echo
        sleep 3
    else
        echo -e " ${E} ${r}Error occurred while processing the file.${n}"
        rm -f "$TEMP_FILE"
        return 1
    fi

    rm -f "$TEMP_FILE"
    clear
}

banner() {
    echo
    echo
    echo -e "   ${y}______  _____________________  _______  ___   ___    ________________"
    echo -e "   ${y}___   |/  /__    |_  ___/_  / / /__   |/  /   __ |  / /__    |___  _/"
    echo -e "   ${y}__  /|_/ /__  /| |____ \_  / / /__  /|_/ /    __ | / /__  /| |__  /  "
    echo -e "   ${c}_  /  / / _  ___ |___/ // /_/ / _  /  / /     __ |/ / _  ___ |_/ /   "
    echo -e "   ${c}/_/  /_/  /_/  |_/____/ \____/  /_/  /_/      _____/  /_/  |_/___/   ${n}"
    echo -e "${y}               +-+-+-+-+-+-+-+-+-+"
    echo -e "${c}               |M|A|S|U|M|-|V|A|I|"
    echo -e "${y}               +-+-+-+-+-+-+-+-+-+${n}"
    echo
    
    if [ $random_number -eq 0 ]; then
        echo -e "${b}╭════════════════════════⊷"
        echo -e "${b}┃ ${g}[${n}ム${g}] ᴛɢ: ${y}t.me/MasumVaiBD"
        echo -e "${b}╰════════════════════════⊷"
    else
        echo -e "${b}╭══════════════════════════⊷"
        echo -e "${b}┃ ${g}[${n}ム${g}] ᴛɢ: ${y}t.me/Cyber_Solution_Bangladesh"
        echo -e "${b}╰══════════════════════════⊷"
    fi
    
    echo
    echo -e "${b}╭══ ${g}〄 ${y}𝙼𝙰𝚂𝚃𝙴𝚁 ${g}〄"
    echo -e "${b}┃❁ ${g}ᴄʀᴇᴀᴛᴏʀ: ${y}𝙼𝚊𝚜𝚞𝚖-𝚅𝚊𝚒"
    echo -e "${b}┃❁ ${g}ᴅᴇᴠɪᴄᴇ: ${y}${VENDOR} ${MODEL}"
    echo -e "${b}╰┈➤ ${g}Hey ${y}Dear"
    echo
}

setupx() {
    if [ -d "$PREFIX" ]; then
        tr
        BDnetcheck
        
        banner
        echo -e " ${C} ${y}Detected Termux on Android¡"
        echo -e " ${lm}"
        echo -e " ${A} ${g}Updating Package..¡"
        echo -e " ${dm}"
        echo -e " ${A} ${g}Wait a few minutes.${n}"
        echo -e " ${lm}"
        
        spin
        
        if [ -d "$HOME/MASTER" ]; then
            sleep 2
            clear
            banner
            echo -e " ${A} ${p}Updating Completed...!¡"
            echo -e " ${dm}"
            
            clear
            banner
            echo -e " ${C} ${c}Package Setup Your Termux..${n}"
            echo
            echo -e " ${A} ${g}Wait a few minutes.${n}"
            
            setup
            donotchange
            
            clear
            banner
            echo -e " ${C} ${c}Type ${g}exit ${c}then ${g}enter ${c}Now Open Your Termux¡¡ ${g}[${n}${HOMES}${g}]${n}"
            echo
            sleep 3
            cd "$HOME"
            rm -rf MASTER
            exit 0
        else
            clear
            banner
            echo -e " ${E} ${r}Tools Not Exists Your Terminal..${n}"
            echo
            echo
            sleep 3
            exit 1
        fi
    else
        echo -e " ${E} ${r}Sorry, this operating system is not supported ${p}| ${g}[${n}${HOST}${g}] ${SHELL}${n}"
        echo 
        echo -e " ${A} ${g}Wait for the next update using Linux...!¡"
        echo
        sleep 3
        exit 1
    fi
}

# Main execution
start
help
setupx
