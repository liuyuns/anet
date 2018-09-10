#!/bin/bash

if [ $# -eq 0 ]
 then
    echo "No darknet folder supplied"
    exit 1
fi

ln -s ./darknet $1
