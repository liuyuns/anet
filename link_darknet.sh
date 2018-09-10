#!/bin/bash

if [ $# -eq 0 ]
 then
    echo "No darknet folder supplied"
    exit 1
fi

echo "Link darknet folder to ./darknet"
ln -s $1 ./darknet 

echo "Link {darknet}/data/lables to ./data/lables"
ln -s $1/data/labels ./data/labels
