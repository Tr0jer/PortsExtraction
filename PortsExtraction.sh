#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

trap ctrl_c INT

function ctrl_c(){
	echo -e "\n${yellowColour}[!] Exiting...${endColour}\n"
	tput cnorm; exit 0
}

function helpPanel(){
	echo -e "\n${greenColour}[*] How To Use Ports Extraction${endColour}"
	for i in $(seq 1 32); do
		echo -n "-"
	done;

	echo -e "\n${blueColour}[-e] Extracts Ports From a File${endColour}"
	echo -e "\n\t${greenColour}[*] Usage: ./PortsExtraction.sh -e pwd/file.gnmap${endColour}"
	echo -e "\n\t${yellowColour}[!] You can only use this option with grepable nmap files${endColour}"
	echo -e "\n${blueColour}[-x] Extracts Ports From a File without an Extension .gnmap${endColour}"
	echo -e "\n\t${greenColour}[*] Usage: ./PortsExtraction.sh -x pwd/file${endColour}"
	echo -e "\n\t${yellowColour}[!] Use this option only if You are completly sure that the file contains a grepable text from nmap${endColour}"
	echo -e "\n${blueColour}[-h] Opens The Help Panel${endColour}"
	echo -e "\n\t${greenColour}[*] Usage: ./PortsExtraction.sh -h${endColour}"
}

function extractPorts(){
	local file=$1
	read_in=$(cat $file 2>/dev/null)
	if [[ ${#read_in} -ge 1 ]]; then
		grep_ports=$(echo $read_in | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')
		ip_port=$(echo $read_in | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u)
		echo -e "\n"
		for i in $(seq 1 80); do echo -n "-"; done
		echo -e "\n\n\t${greenColour}[*] Successful Port Extraction${endColour}"
		echo -e "\n\t\t${purpleColour}IP address:${endColour} $ip_port"
		echo -e "\n\t\t${purpleColour}Ports Found: ${endColour}$grep_ports"
		echo -e "\n\t${greenColour}[*] Ports Copied to Clipboard${endColour}\n"
                for i in $(seq 1 80); do echo -n "-"; done
		echo -e "\n"
		echo $grep_ports | tr -d "\n" | xclip -sel clip
	else
		echo -e "\n${redColour}[x] File not found${endColour}"
		ctrl_c
	fi
}

parameter_counter=0; while getopts "e:x:h" arg; do
	case $arg in
		e) extract=$OPTARG; let parameter_counter+=1;;
		x) xt=$OPTARG; let parameter_counter+=1;;
		h) helpPanel; let parameter_counter+=1;;
	esac
done;

if [ $parameter_counter -eq 0 ]; then
	echo -e "\n${redColour}[x] Missing Argument${endColour}"
	for i in $(seq 1 50); do echo -n "-"; done
	echo -e "\n\tUse './PortsExtraction.sh -h' to get help"
else
	if [[ -n "$xt" ]]; then
		extractPorts $xt
	elif [[ -n "$extract" ]]; then
		file="${extract##*/}"
		if [ $(echo "${file#*.}") == "gnmap" ]; then
			extractPorts $extract
		else
			echo -e "\n${redColour}[x] Unable to upload a file without extension .gnmap${endColour}\n"
			ctrl_c
		fi
	fi
fi

