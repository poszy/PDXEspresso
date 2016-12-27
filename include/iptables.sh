#!/   bin/sh
# Author  : Luis M Pena
# Date    : 12/24/2016
# Purpose : IP Table functions that are managed by manage.sh
# This was put into a seprate script as a sourcee file. 
# Makes it easier for me to manage and read these scripts.


# Setting Global Variables to make things easier and faster
# I Really dont care about conventional coding when it comes to shell scripting

    #Drop all NULL PACKETS
    #iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
    
    # Prevent syn-flood attack
    #iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
    
    # Prevent XMAS packets
    #iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP

    #Find wired nic, assuming lo or eth0, we need to allow traffic to one of these interfaces.
    #iptables -A INPUT -i lo -j ACCEPT
    
    #iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
    #iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT

    # Set Variables For functions
    _IPDISPLAY=$( iptables -L);
    _IPFLUSH=$( iptables -F);
   

function press_enter {

    echo ""
    echo -n "Press Enter To continue"
    read
    clear

}


function reset {
    main
    
} 


function add_port {

    
    
    echo "What kind of protocol would you like to add"
    echo "1) TCP";
    echo "2) UDP";
    
    # SET PROTOCOL CHOICE
    _PROTO=
    read _PROTO

   if [ "$_PROTO" = "1" ];
    
   then
    
    echo "Which TCP port do you want to add?";
     
    # Add Ports Varaibles
    #variable that gets port number
    _PORT=
    read _PORT;
    
    iptables -A INPUT -p tcp -m tcp --dport "$_PORT" -j ACCEPT

    
    echo "Done ..." 
    echo "Added port $_PORT"

    else
    echo "Which UDP port do you wish to add"
     iptables -A INPUT -p udp -m udp --dport "$_PORT" -j ACCEPT 

    

    fi 
}

function remove_port {

    echo "Removing multiple ports";
    # Remove Ports Varables
    _IPBLKTCP=$( iptables -L);
    _IPBLKUDP=$( iptables -L);
}


function nuke_tables { 
    _IPNUKE=
    
    echo "Nuke IP TABLES AND ALL CHAINS AND ALL POLCIES?"
    echo " Y or N"
    
    read _IPNUKE

    if [ "$_IPNUKE" = "Y" ]
    then
    echo " Now nuking firewall"
    iptables -F
    iptables -X
    iptables -t nat -F
    iptables -t nat -X
    iptables -t mangle -F
    iptables -t mangle -X
    iptables -t raw -F
    iptables -t raw -X
    iptables -t security -F
    iptables -t security -X
    iptables -P INPUT ACCEPT
    iptables -P FORWARD ACCEPT
    iptables -P OUTPUT ACCEPT

    
    echo "Done..."

    else
	echo "You decided to rethink your life.."
	echo "Now exiting"
	exit 0
    fi
}

function restore_tables {
   
    echo "What would you like to do?"
    echo "1) Save current IP Tables rules, this will apply rules if rebooted"
    echo "2) Restore IP tables from file"
   
     # SET PROTOCOL CHOICE
    _CHOICE=
    read _CHOICE

   if [ "$_CHOICE" = "1" ]
    then
    iptables-save > source/saved
    
   else
    echo "Full path to restore file, full path and name..";
    
    _IPPATH=
    read _IPPATH
    
    iptables-restore < "$_IPPATH"
    echo "Done.."

   fi
}

function remove_iptables {

    #This function will remove the binary from the operating system
    # Full uninstall including configuration files
    # Use with caution
    
    echo " Removing IP Tables package and configuration files... you have been warned"
  
    

    echo "Done..."
}


function install_iptables {

    #this function will donwload and install iptables depending on your OS and package manager
    echo "Installing IP tables";

    _IPINSTALL=$( iptables -L);


    echo "Done ..."
}

function ip_tables {

    _IPCHOICE= 
    echo "How Would you like to manage IP tables?";

    echo "1) Display IP Tables";
    echo "2) Flush IP Tables";
    echo "3) Add new Port to LISTEN";
    echo "4) Block new port";
    echo "5) NUKE POLICY & CHAIN & RULES";
    echo "6) Restore firewall from file";
    echo "7) Remove IPtables & configuration files";
    echo "8) Install iptables";

    read _IPCHOICE

case $_IPCHOICE in

    1) echo "$_IPDISPLAY"; press_enter ;;
    2) echo "$_IPFLUSH" ; press_enter ;;
    3) add_port ; press_enter ;;
    4) remove_port ; press_enter ;;
    5) nuke_tables ; press_enter ;;
    6) restore_tables ; press_enter ;;
    7) echo "$_IPREMOVE" ; press_enter ;;
    8) echo "$_IPINSTALL" ; press_enter ;;

    0) exit ;;
    *) echo "Enter a digit above and try not to break this program.";

      esac

} # end ip_tables

function main {

    echo "Main Function";
    ip_tables

}

# Run main function
main


