#!/bin/bash

#Automatically run recon against a domain/list of domains.
#
# Current Features: 
# * DNS Recon
# * Email Harvesting
# * Meta Data Enumeration
# * WhoIs
#
# Additional Features
# * Pull domains from SSL Certificate
#
# Usage: ./automator.sh listofdomains.txt
# Usage: ./automator.sh domain.com
#
# By: Leon Teale (@leonteale)
#

## Setting Coloured variables
red=`echo -e "\033[31m"`
lcyan=`echo -e "\033[36m"`
yellow=`echo -e "\033[33m"`
green=`echo -e "\033[32m"`
blue=`echo -e "\033[34m"`
purple=`echo -e "\033[35m"`
normal=`echo -e "\033[m"`
 
## Variables
version="2.0"
domain="$1"


## Check for correct usage
usage () {
			if [ -z "$1" ];
				then
					#echo "$red Incorrect Usage!$normal"
					#echo "Usage: ./automator.sh listofdomains.txt"
					echo "Usage: ./automator.sh domain.com"
					echo ""
					exit 1
			fi
		}

## Display script header
header ()  {	
				clear
				echo "$yellow                _                        _             "
				echo "$yellow     /\        | |                      | |            "
				echo "$yellow    /  \  _   _| |_ ___  _ __ ___   __ _| |_ ___  _ __ "
				echo "$yellow   / /\ \| | | | __/ _ \| '_ \` _ \ / _\` | __/ _ \| '__|"
				echo "$yellow  / ____ \ |_| | || (_) | | | | | | (_| | || (_) | | "  
				echo "$yellow /_/    \_\__,_|\__\___/|_| |_| |_|\__,_|\__\___/|_|$normal$yellow (version $green$version$yellow)"
				echo "$lcyan  -- by Leon Teale (@leonteale)"
				echo ""
				echo "$blue +-------------------------------------------+"
				echo "$blue | $red Current Features$normal                      $blue   |$normal"
				echo "$blue | $yellow * DNS Recon$normal                           $blue   |$normal"
				echo "$blue | $yellow * Email Harvesting$normal                     $blue  |$normal"
				echo "$blue | $yellow * Meta DataEnumeration$normal                 $blue  |$normal"
				echo "$blue | $yellow * WhoIs$normal                                  $blue|$normal"
				echo "$blue |                                           |"
				echo "$blue | $red Additional Features            $normal         $blue |$normal"
				echo "$blue | $yellow * Pull domains From SSL Cert$normal$blue             |$normal"
				echo "$blue +-------------------------------------------+$normal"
				echo "$lcyan Target = '$green$domain$lcyan'$normal"
				echo ""
			}

## check  environment is set up correctly before continueing
prerequisits () {
					##need to make checks that the programs are installed first##
					##														   ##
					mkdir -p ~/Desktop/automator_results/
					mkdir -p ~/Desktop/automator_results/$domain
					mkdir -p ~/Desktop/automator_results/$domain/metagoofil
				}

DNSrecon () {
				echo "Run intense scan? [y/N]"
				read intense

				if [[ $intense  == y ]]; 
					then
						dnslist="dnslistlong"
					else
						dnslist="dnslistshort"
				fi

				echo $dnslist
			}


usage $1
header
prerequisits
DNSrecon


