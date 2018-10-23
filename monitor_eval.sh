#!/bin/bash

cfg_name=$1
shift

if [ "$cfg_name" == "" ];
    then
    echo ""
    echo "  Usage:"
    echo "    $0 [cfg_name] [width/height ratio]"
    echo "      [cfg_name], e.g. yolov3-anet, anet-icons"
    echo "      [width/height ratio] e.g. 16/28"

    exit  1
fi

w_h=$1
if [ "$w_h" == "" ]; then
  w_h=1
fi

shift

last_weight=none

[ -d output ] || mkdir output

cfg_file=cfg/test-${cfg_name}.cfg

while true
do
    weight=$( ls backup/${cfg_name} -t | head -1 )
    if [ "$weight" == "$last_weight" ];
        then 
        echo "Same weight, sleep 1m until next check...."
        sleep 2m
        continue
    fi

    last_weight=$weight

    ./batch_eval.sh $cfg_file $weight $w_h
 
done



