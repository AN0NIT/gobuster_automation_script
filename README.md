## Gobuster Automation Script

## Usage ./gobuster_script.sh IP OS
## The choice for OS is "windows" and "linux"
## First it checks whether if there is a gobuster directory, else it will create one.
## Then it does the gobuster scan on the specified IP

## After saving the inital gobuster log, the python script separate "directories"  found in the log file, and uses it for futher enumeration


## This script requires python3 ("script.py is included")
## The script runs gobuster on the IP specified and saves them to gobuster/ directory
## This script has a lot of flaws which I am trying to fix.
## If you find any Bug/Flaw please feel free to modify the code, and let me know
## Thank you for viewing my code!!
