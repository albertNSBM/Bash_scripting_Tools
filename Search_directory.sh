#!bin/bash

# This is the script That allow user to enter the pattern and directory 
# and then you search that pattern in the file and line where that pattern is.

echo "Enter pattern to search:"
read pattern 
echo "Enter directory:"
read directory 

grep "$pattern" "$directory" -n
