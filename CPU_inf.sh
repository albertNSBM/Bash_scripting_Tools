#!/bin/bash

# CPU Information 
echo "----------"
echo "|CPU Info|"
echo "----------"
lscpu | grep -E '^Thread|^Core|^Socket|^CPU\(' 
echo "-----------"
echo "| RAM INFO|"
echo "-----------"
free -m | grep Mem
echo "-----------------"
echo "|Disk Management|"
echo "-----------------"
df -h | grep '^/dev'
