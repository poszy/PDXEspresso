#!/bin/bash
# Author  : Luis M Pena
# Date    : 12/15/2016
# Purpose : Main script for various system administration scripts.
# This script is intended to perform various admin tasks that are focused to save time.
# Script needs super user access. NO EXCEPTIONS.

# Include Source Files
source ./include/source/general_functions.sh
source ./include/source/main_functions.sh

echo "

                                                                                                          
______________   __  _____                                   
| ___ \  _  \ \ / / |  ___|                                  
| |_/ / | | |\ V /  | |__ ___ _ __  _ __ ___  ___ ___  ___   
|  __/| | | |/   \  |  __/ __| '_ \| '__/ _ \/ __/ __|/ _ \  
| |   | |/ // /^\ \ | |__\__ \ |_) | | |  __/\__ \__ \ (_) | 
\_|   |___/ \/   \/ \____/___/ .__/|_|  \___||___/___/\___/  
                             | |                             
                             |_|                          


";

function main {

#Run create_dirs function
check_root
create_dirs

INPUT=

until [ "$INPUT" = "0" ]; do

echo "What would you like to do?";

echo "1)  Scan Ports";
echo "2)  User & Group Management"; #Check Loged in users
echo "3)  Search For config Files";
echo "4)  Display CPU Info";
echo "5)  SSH Management";
echo "6)  Apache Management";
echo "7)  IP Tables Management";
echo "8)  Find Package Information";
echo "9)  Find Distro Information";
echo "10) Tail Auth log";
echo "11) clear all debug logs and clear all temp files";
echo "12) Find Services ";

read INPUT

case $INPUT in

    1) scan_ports ; press_enter ;;
    2) find_users ; press_enter ;;
    3) free ; press_enter ;;
    4) find_cpui ; press_enter ;;
    5) manage_sshd ; press_enter ;;
    6) free ; press_enter ;;
    7) init_tables ; press_enter ;;
    8) free ; press_enter ;;
    9) free ; press_enter ;;
    10) free ; press_enter ;;
    11) free ; press_enter ;;
    12) free ; press_enter ;;

    0) exit ;;
    *) echo "Enter a digit above and try not to break this program.";


      esac
done

} # end main


# Calling main function.
# This loops the progra and allows a user to get .
# Out of a sub menu and back to the main program.
main