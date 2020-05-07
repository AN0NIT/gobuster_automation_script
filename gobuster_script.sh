#!/bin/bash


echo "[+]Running Gobuster automation script..."
if [ ! -d "gobuster" ]; then
	mkdir "gobuster"
fi

touch gobuster/put.txt

if [ "$1" != '' -a "$2" != '' ]; then
	IP="$1"
	OS="$2"

else 
	printf "You didnt specify the IP or OS\n"
	printf "Syntax: ./gobuster_automation.sh <ip addr> <OS>\n"
	printf "OS can be: linux/windows\n"
	exit
fi

echo "[+]Running initial gobuster scan..."
if [ "$OS" == "linux" ]; then
	gobuster dir -u http://$IP --timeout 10m -b 404,401,403 -w /usr/share/dirb/wordlists/common.txt -x .php,.html,.txt,.sql,.db,.cgi -o gobuster/gobuster.log
elif [ "$OS" == "windows" ]; then
	gobuster dir -u http://$IP --timeout 10m -b 404,401,403 -w /usr/share/dirb/wordlists/common.txt -x  .php,.aspx,.txt,asp,.sql,.db -o gobuster/gobuster.log
else 
	printf "The OS u specified is wrong\n"
	printf "Enter  either 'windows'/'linux'\n"
	exit
fi

if [ "$OS" == "linux" ]; then
	grep -Ev '404|403|401' gobuster/gobuster.log > gobuster/direct.txt
else
	grep -Ev '404|403|401' gobuster/gobuster.log > gobuster/direct.txt
fi


python3 script.py

while read str; do
	if [ "$OS" == "linux" ]; then
		echo "[+]Running gobuster on $str directory"
		gobuster dir -u http://$IP$str  --timeout 300s -b 404,403,401 -w /usr/share/dirb/wordlists/common.txt -x .php,.html,.txt,.sql,.db,.cgi -o gobuster$str.log
		sleep 60s
	else
                echo "[+]Running gobuster on $str directory"
		gobuster dir -u http://$IP$str --timeout 300s -b 404,403,401 -w /usr/share/dirb/wordlists/common.txt -x  .php,.aspx,.txt,asp,.sql,.db -o gobuster$str.log
	fi
done < gobuster/put.txt

rm gobuster/direct.txt
rm gobuster/put.txt
sleep 3s

printf "\nAutomation Done..."
printf "\nOutput saved in gobuster/ directory"
printf "\nBye...\n"
