#!/bin/bash

# tool that create the backup of the all logs in a file

backup="/backup/$(date +%Y-%m-%d-%H-%M-%S)"

mkdir -p "$backup"

for file in /var/log/*.log
do 
	cp "$file" "$backup"
done
echo "Back up done."
