#!/bin/bash
function Max()
{
echo "Enter the Directory path:"
read directory

echo "Enter the Minimum size:"
read minimun

echo "Enter the Maximum size:"
read maximum

find "$directory" -type f -size +"$minimum"c -size -"maximum"c
}
Max
