#!/bin/bash
#######################
# Chromebook key remapping utility
#  
# Disclaimer: 
# I am not responsible for any damage or bricking of your device
# By using this script, you acknowledge this.
#
# Created by Lioncat6:
# https://github.com/Lioncat6
#
#######################
Remap_util_date="12/6/23"

# Function to quicly clear the terminal
function cls(){
      printf "\ec"
}

# Reset
Color_Off='\033[0m'       # Text Reset
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White
# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White
# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White
# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White

cls
echo -e "ChromeOS Keyboard Remapping Utility ${IGreen}${Remap_util_date}${Color_Off} by Lioncat6"
sleep 1
#echo -e "${BIWhite}Press ${BIPurple}Enter${BIWhite} to begin${Color_Off}"
#read -re 

function menu(){
    cls
    echo -e "For support please see ${IWhite}https://github.com/Lioncat6/remap-util${Color_Off}"
    echo -e ${BIYellow}"1) ${IWhite} - ${ICyan}Remap keys${Color_Off}"
    echo -e ${BIYellow}"2) ${IWhite} - ${ICyan}Restore original keybinds${Color_Off}"
    echo -e ""
    echo -e ${BIRed}"Q) ${IWhite} - ${IYellow}Quit${Color_Off}"
    echo -e ${BIRed}"R) ${IWhite} - ${IYellow}Reboot${Color_Off}"
    echo -e ${BIRed}"S) ${IWhite} - ${IYellow}Shutdown${Color_Off}"
    echo -e "${Yellow}Please pick one of the above options...${Color_Off}"
    read -re menuChoise
    case "$menuChoise" in
        1)
        topRow
        ;;
        2)
        restoreBackup
        ;;
        Q)
        exit
        ;;
        R)
        sudo reboot
        ;;
        S)
        sudo shutdown -h now
        ;;
        *)
        menu
        ;;
    esac
}

function topRow(){
    cls
    echo -e "${IWhite}Remapping top row keys and adding shortcuts...${Color_Off}"
    sleep 1
    echo -e "Backing up old config file to ${BIWhite}/usr/share/X11/xkb/symbols/pc.bck${Color_Off}"
    sudo cp -n /usr/share/X11/xkb/symbols/pc /usr/share/X11/xkb/symbols/pc.bck
    echo -e "Copying new config file to ${BIWhite}/usr/share/X11/xkb/symbols/pc${Color_Off}"
    sudo cp pc /usr/share/X11/xkb/symbols/
    echo -e "Does your device have a lock key? [Y,N]"
    read -re response
    case "$response" in 
        Y) 
        lockKey
        ;;
        *)
        promptRestart
        ;;
    esac
    
    
}

function restoreBackup(){
    if test -f /usr/share/X11/xkb/symbols/pc.bck
        then 
            echo -e "Restoring backup config file to ${BIWhite}/usr/share/X11/xkb/symbols/pc${Color_Off}"
            sudo cp /usr/share/X11/xkb/symbols/pc.bck /usr/share/X11/xkb/symbols/pc
        else 
            echo -e "Backup file at /usr/share/X11/xkb/symbols/pc does not exist... skipping"
    fi
    if test -f /usr/share/X11/xkb/symbols/inet.bck
        then 
            echo -e "Restoring backup config file to ${BIWhite}/usr/share/X11/xkb/symbols/inet${Color_Off}"
            sudo cp /usr/share/X11/xkb/symbols/inet.bck /usr/share/X11/xkb/symbols/inet
        else 
            echo -e "Backup file at /usr/share/X11/xkb/symbols/inet does not exist... skipping"
    fi
    promptRestart
}   

function lockKey(){
    echo -e "Backing up old config file to ${BIWhite}/usr/share/X11/xkb/symbols/inet.bck${Color_Off}"
    sudo cp -n /usr/share/X11/xkb/symbols/inet /usr/share/X11/xkb/symbols/inet.bck
    echo -e "Copying new config file to ${BIWhite}/usr/share/X11/xkb/symbols/inet${Color_Off}"
    sudo cp inet /usr/share/X11/xkb/symbols/
    promptRestart
}


function promptRestart(){
    echo -e "${BIRed}The device needs to restart to apply these changes${Color_Off}"
    echo -e "${BIWhite}Press ${BIPurple}Enter${BIWhite} to restart${Color_Off}"
    read -re
    sudo reboot
}

menu