#!/bin/bash

wgshow() {
    sudo wg show    
}

line() {
    echo -e "${COL2}----------------------------------------------------------${NC}"
}

while [ 1 ]; do
    clear

    #determining whether VPN is enabled
    STR=$(wgshow)
    case "${STR:0:1}" in
        "i") ON=true ;;
        *) ON=false ;;
    esac

    COL1='\033[1;33m' # yellow
    COL2='\033[1;30m' # dark gray
    NC='\033[0m' # no color

    if $ON ; then
        TEXT1="off"
        COL3='\033[1;32m' # light green
    else
        TEXT1="on"
        COL3='\033[1;31m' # light red
    fi

    echo -e "${COL2}----------------------${COL3}Wireguard VPN${COL2}-----------------------${NC}"
    wgshow
    if $ON ; then
        line
    fi
    echo -e " ${COL1}1${NC}- turn $TEXT1 VPN"
    echo -e " ${COL1}2${NC}- exit script"
    line
    echo -n "Enter command: "

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
        echo "Entered wrong command"
        read;;
    esac
done
