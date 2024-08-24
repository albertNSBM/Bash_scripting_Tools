#!/bin/bash

total_size=0

for file in /home/*
do
	if [ -d "$file" ]
	then
		dir_size=$(sudo du -s "$file" | awk '{print $1}')
		total_size=$((total_size+dir_size))
	fi
done
echo "The size of Directory is :$total_size"
