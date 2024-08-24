#!/bin/bash/

# Scripts that add the execution permision to all script file in the current directory

for file in *.sh
do
	chmod +x "$file"
done

echo "File Permission Changed Succesful"
