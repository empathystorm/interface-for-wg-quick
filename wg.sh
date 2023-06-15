#!/bin/bash

wgshow() {
    sudo wg show    
}

line() {
    echo -e "${COL2}----------------------------------------------------------${NC}"
}

while [ 1 ]; do
    clear

    #определение, включен ли VPN
    STR=$(wgshow)
    case "${STR:0:1}" in
        "i") ON=true ;;
        *) ON=false ;;
    esac

    COL1='\033[1;33m' # yellow
    COL2='\033[1;30m' # dark gray
    NC='\033[0m' # no color

    if $ON ; then
        TEXT1="выключить"
        COL3='\033[1;32m' # light green
    else
        TEXT1="включить"
        COL3='\033[1;31m' # light red
    fi

    echo -e "${COL2}----------------------${COL3}Wireguard VPN${COL2}-----------------------${NC}"
    wgshow
    if $ON ; then
        line
    fi
    echo -e " ${COL1}1${NC}- $TEXT1 VPN"
    echo -e " ${COL1}2${NC}- выйти из скрипта"
    line
    echo -n "Введите команду: "

    read OPT
    
    case $OPT in
    1)
    	if $ON ; then
    		sudo wg-quick down wg0
    	else
    		sudo wg-quick up wg0
    	fi;;
    2)
    	clear
    	exit;;
    *)
    	echo "Введена неправильная команда"
    	read;;
    esac
done
