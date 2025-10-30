#!/bin/bash
clear

# BD color scheme
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
lm='\033[1;96m▱▱▱▱▱▱\033[1;0m〄\033[1;96m▱▱▱▱▱▱\033[1;00m'
dm='\033[1;93m▱▱▱▱▱▱\033[1;0m〄\033[1;93m▱▱▱▱▱▱\033[1;00m'

URL="https://master-chat-hew1.onrender.com"
USERNAME_DIR="$HOME/.Master-Masum"
USERNAME_FILE="$USERNAME_DIR/usernames.txt"
random_number=$(( RANDOM % 2 ))

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
        echo -e "${E} ${r}Failed to connect to internet${n}"
        return 1
    fi
    
    clear
}

load() {
    clear
    echo -e " ${r}●${n}"
    sleep 0.2
    clear
    echo -e " ${r}●${y}●${n}"
    sleep 0.2
    clear
    echo -e " ${r}●${y}●${b}●${n}"
    sleep 0.2
}

broken() {
    clear
    echo
    echo -e "${c}        _(\___/)"
    echo -e "      =( ´ ${g}•⁠${p}ω${g}• ⁠${c})=   ˖<💌>."
    echo -e "      // ͡     )︵)"
    echo -e "     (⁠人_____づ_づ"
    echo
    sleep 0.5
    clear
    echo
    echo -e "${c}        _(\___/)"
    echo -e "      =( ´ ${g}•⁠${p}ω${g}• ⁠${c})=   𖥔˖<💘>.𖥔"
    echo -e "      // ͡     )︵)"
    echo -e "     (⁠人_____づ_づ"
    echo
    sleep 0.5
    echo -e " ${C} ${g}Goodbye! ${y}(${c}-${r}.${c}-${y})${c}Zzz・・・・𑁍ࠬܓ"
    echo
    exit 0
}

goodbye() {
    clear
    echo
    echo -e "${c}      ࿔‧ ֶָ֢˚˖𐦍˖˚ֶָ֢ ‧࿔      ╱|、"
    echo -e "                      (${b}˚${p}ˎ ${b}。${c}7"
    echo -e "                       |、~〵"
    echo -e "                       じしˍ,)ノ"
    echo
    sleep 0.5
    echo -e " ${C} ${g}Goodbye! ${y}(${c}-${r}.${c}-${y})${c}Zzz・・・・ཐི|ཋྀ"
    echo
    exit 0
}

BDhelp() {
    clear
    echo
    echo -e " ${p}■ \e[4m${g}Use Tools\e[0m ${p}▪︎${n}"
    echo
    echo -e " ${y}Enter ${g}q ${y}Exit Tool${n}"
    echo
    echo -e "             ${g}q"
    echo
    echo -e " ${b}■ \e[4m${c}If you understand, click the Enter Button\e[0m ${b}▪︎${n}"
    read -r -p ""
}

check_warnings() {
    local warning
    warning=$(curl -s "$URL/warnings" 2>/dev/null | jq -r --arg user "$username" '.[] | select(.username == $user) | "Are You Warned — °|\(.username)|°  \(.warning)"' 2>/dev/null)
    if [ -n "$warning" ]; then
        echo -e "         ${r}$warning${n}"
    fi
}

display_messages() {
    clear
    local banned
    banned=$(curl -s "$URL/ban" 2>/dev/null | jq -r --arg user "$username" '.[] | select(.username == $user) | "Are You banned — °|\(.username)|°  \(.bn_mesg)"' 2>/dev/null)
    
    if [ -n "$banned" ]; then
        load
        echo -e "     ${c}____    __    ____  _  _     _  _ "
        echo -e "    ${c}(  _ \  /__\  (  _ \( )/ )___( \/ )"
        echo -e "    ${y} )(_) )/(__)\  )   / )  ((___))  ("
        echo -e "   ${y} (____/(__)(__)(_)\_)(_)\_)   (_/\_)\n"
        echo -e "         ${r}$banned${n}"
        echo
        exit 0
    fi

    load
    while true; do
        clear
        echo -e " ${r}●${y}●${b}●${n}"
        check_warnings
        
        local D T
        D=$(date +"${c}%Y-%b-%d${n}")
        T=$(date +"${c}%I:%M %p${n}")
        
        echo -e "${lm}"
        echo -e " $D"
        echo -e "  ${c}┏┓┓┏┏┓┏┳┓"
        echo -e "  ${c}┃ ┣┫┣┫ ┃               ${C} ${g}t.me/MasumVaiBD"
        echo -e "  ${c}┗┛┛┗┛┗ ┻"
        echo -e "  $T"
        echo -e "${lm}"

        local msg ads
        msg=$(curl -s "$URL/messages" 2>/dev/null | jq -r '.[] | "\(.username): \(.message)"' 2>/dev/null)
        echo -e "${g}$msg"
        
        ads=$(curl -s "$URL/ads" 2>/dev/null | jq -r '.[]' 2>/dev/null)
        if [ -n "$ads" ]; then
            echo -e "${c}$ads${c}\n"
        fi

        local message
        read -r -p "[+]─[Enter Message | $username]──➤ " message
        
        if [[ "$message" == "q" ]]; then
            echo
            echo -e "\n ${E} ${r}Exiting..Tool..!\n"
            sleep 1
            if [ $random_number -eq 0 ]; then
                goodbye
            else
                broken
            fi
            break
        elif [ -n "$message" ]; then
            curl -s -X POST -H "Content-Type: application/json" \
                 -d "{\"username\":\" 〄 $username\", \"message\":\"$message\"}" \
                 "$URL/send" >/dev/null 2>&1
        fi
    done
}

save_username() {
    clear
    load
    echo -e "        ${c}____    __    ____  _  _     _  _ "
    echo -e "       ${c}(  _ \  /__\  (  _ \( )/ )___( \/ )"
    echo -e "       ${y} )(_) )/(__)\  )   / )  ((___))  ("
    echo -e "      ${y} (____/(__)(__)(_)\_)(_)\_)   (_/\_)\n\n"
    
    echo -e " ${A} ${c}Enter Your Anonymous ${g}Username${c}"
    echo
    read -r -p "[+]──[Enter Your Username]────► " username

    if [[ -z "$username" ]]; then
        echo -e "${r}Username cannot be empty!${n}"
        save_username
        return
    fi

    sleep 1
    clear
    echo
    echo -e "		        ${g}Hey ${y}$username"
    echo -e "${c}              (\_/)"
    echo -e "              (${y}^ω^${c})     ${g}I'm Masum-Vai${c}"
    echo -e "             ⊂(___)づ  ⋅˚₊‧ ଳ ‧₊˚ ⋅"
    echo
    echo -e " ${A} ${c}Your account created ${g}Successfully¡${c}"
    
    mkdir -p "$USERNAME_DIR"
    echo "$username" > "$USERNAME_FILE"
    echo
    sleep 1
    echo -e " ${D} ${c}Enjoy Our Chat Tool¡"
    echo
    read -r -p "[+]──[Enter to back]────► "
    BDhelp
    display_messages
}

# Check dependencies
if ! command -v curl >/dev/null 2>&1; then
    pkg install curl -y >/dev/null 2>&1
fi

if ! command -v jq >/dev/null 2>&1; then
    pkg install jq -y >/dev/null 2>&1
fi

mkdir -p "$USERNAME_DIR"

# Load username if exists
if [ -f "$USERNAME_FILE" ]; then
    username=$(cat "$USERNAME_FILE")
else
    save_username
    username=$(cat "$USERNAME_FILE")
fi

# Start displaying messages
BDnetcheck
display_messages
