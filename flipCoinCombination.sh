#!/bin/bash

if [[ $((RANDOM%2)) == 0 ]]
then
    echo "head"
else
    echo "tail"
fi
