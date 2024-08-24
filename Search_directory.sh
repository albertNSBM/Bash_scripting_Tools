#!bin/bash

# This is the script That allow user to enter the pattern and directory 
# and then you search that pattern in the file and line where that pattern is.

echo "Enter pattern to search:"
read pattern 
echo "Enter directory:"
read directory 

grep "$pattern" "$directory" -n

# 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
