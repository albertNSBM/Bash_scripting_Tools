#!/bin/bash 

# Analzing all the gz file and find the line containing "Failed password"

figlet " Auth.nalyzer"


function Failed_total()
{
sum=0
for file in *.gz 
do 
	number=$(zcat $file | grep -i Failed | wc -l) 
	sum=$((sum+number))
	
done 
echo -e "[*] Total of All Failed attempt in all files: \e[32m $sum \e[0m"
}

function Frequently_ip()
{
		for file in *.gz
		do 
			zcat $file | grep -i Failed | awk '{print $(NF-3)}'|sort | uniq -c | sort -n >>IPs
		done
		echo -e "[*] The most frequent IP: \e[32m $(cat IPs | tail -n1 | awk '{print $2}') \e[0m"
		rm -f IPs
}

function Top3_username()
{
	for file in *.gz
	do 
			zcat $file | grep -i Failed | awk '{print $(NF-5)}' >> Uname
	done 
	echo "[*] Top 3 Usernames Used:"
	echo ""
	cat Uname | sort | uniq -c | sort -n | tail -n3
	rm -f Uname
}


function IPs_Faimore_10 ()
{
	Total=0
	for file in *.gz 
	do 
		number=$(zcat $file | grep Failed -i | awk '{print $(NF-3)}' | sort |uniq -c | awk '$1>10' | sort -n | wc -l )
		Total=$((Total+number))
		
	done
	echo ""
	echo -e "[*] Total Number of IPs Failed more than 10 times: \e[32m $Total \e[0m"	
}

function IPs_Russia()
{
	for file in *.gz
	do 
		zcat $file | grep Failed -i | awk '{print $(NF-3)}' >> All_Ip
	done
	cat All_Ip | sort | uniq -c | sort -n | awk '$1>100' | awk '{print $2}' > more_100
	count=0
	for i in $(cat more_100)
	do 
		if [ "$(geoiplookup $i | grep Russia -i)" ]
		then
			count=$((count + 1))
		fi
	done 
	echo ""
	echo -e "[*] All address from Russia are: \e[32m $count \e[0m"
	rm -f All_Ip
	rm -f more_100
}

function Accepted_password()
{
	for file in *.gz 
	do 
		zcat $file | zgrep "Accepted password"  -i | awk '{print $(NF-3)}' >> ACPT.ip		
		
	done 
	
	echo ""
	echo -e "[*] Total Accepted Password: \e[32m  $(cat ACPT.ip | sort | uniq | wc -l ) \e[0m"
	echo ""
	echo "[*] All IPs with Accepted Passwords:"
	echo ""
	echo -e "\e[32m $(cat ACPT.ip | sort | uniq ) \e[0m"
	echo ""
	
	rm -f ACPT.ip
}

function MD5()
{
	for file in *.gz
	do
		zcat $file | grep Failed -i | awk '{print $(NF-3)}' >> All_IP 
	done
	cat All_IP | sort | uniq -c | sort -n | awk '$1>500' | awk '{print $2}' > more_500
	hash=$(cat more_500 | md5sum | awk '{print $1}')
	echo -e "[*] The MD5 of all more_500 Ips is: \e[35m $hash \e[0m"
	rm -f All_IP
	rm -f more_500
}

function All_entries ()
{    Total=0
	for file in *.gz 
	do 
		count=$(zcat $file | wc -l )
		Total=$((Total+count))
	done
	echo ""
	echo -e "[*] Total number of  All Entries are :\e[32m $Total \e[0m"
	
}

function Duplicated()
{
	for file in *.gz
	do 
		zcat $file >>All_Rec
	done 
	echo "[*] Duplicated line is :"
	echo ""
	cat All_Rec | sort | uniq -c | sort -n | awk '$1>1'
	rm -f All_Rec
}


function MAIN()
{
	Failed_total
	Frequently_ip
	Top3_username
	IPs_Faimore_10
	IPs_Russia
	Accepted_password
	MD5
	All_entries
	Duplicated
}
MAIN
