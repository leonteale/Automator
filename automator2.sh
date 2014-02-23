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
results_dir="~/Desktop/automator_results/"


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
					mkdir -p $results_dir
					mkdir -p $results_dir$domain
					mkdir -p $results_dir$domain/metagoofil
				}

zone_transfer () {
					name_server=`dig ns $domain | grep -v '^;' | grep NS | cut -f5 | head  -1`
					if dig @$name_server $domain axfr | grep "Transfer failed"
					 	then
					 		echo "$lcyan Zone Transfer Vulnerability: ($green No $lcyan)$normal"
					 	else
					 		echo "$lcyan Zone Transfer Vulnerability: ($red Yes $lcyan)$normal"
					fi
}

DNSrecon () {
				echo "Run intense DNS scan? [y/N]"
				read intense

				if [[ $intense  == y ]]; 
					then
						dnslist="dnslistlong.txt"
					else
						dnslist="dnslistshort.txt"
				fi			

				zone_transfer
				
				echo "$yellow Running DNS recon stage"
				echo ""
				./programs/dnsrecon/dnsrecon.py -t brt,std,axfr -D $dnslist -d $domain > $results_dir/$domain/full_dnsrecon.txt
				cat $results_dir/$domain/full_dnsrecon.txt | grep '[^\.][0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}[^\.]' | grep -vE 'Trying|TCP|MX|NS|SOA|Has' | awk {'print $3 "\t" $4'} | sort -u  | sed '/^$/d' > $results_dir/$domain/dnsrecon.txt 
				echo "$lcyan Subdomains found: ($yellow `cat $results_dir/$domain/dnsrecon.txt | wc -l` $lcyan)$normal"
				cat  $results_dir/$domain/dnsrecon.txt				
			}

email_harvest () {

echo 2
}


user_harvest () {
echo  2


}



usage $1
header
prerequisits
DNSrecon


