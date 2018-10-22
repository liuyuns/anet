#!/bin/bash

cfg_name=$1
shift

if [ "$cfg_name" == "" ];
    then
    echo ""
    echo "  Usage:"
    echo "    $0 [cfg_name]"
    echo "      [cfg_name], e.g. yolov3-anet, anet-icons"

    exit  1
fi

eval_script=$1

last_weight=none

test_images=( "Android_2_Pro_Cart_Input_Cart.png" "IOS_2_Pro_Cart_Input_Button.png" "Web_2_Pro_Cart_Ham.png" )

[ -d output ] || mkdir output

while true
do
    weight=$( ls backup/${cfg_name}* -t | head -1 )
    if [ $weight == $last_weight ];
        then 
        echo "Same weight, sleep 1m until next check...."
        sleep 1m
        continue
    fi

    last_weight=$weight

    base_name=`basename $weight`

    log="output/${base_name}_result.log"

    for image in "${test_images[@]}"
    do
        echo "Run detection for ${image}"
        if [ "$eval_script" == "" ];
          then
          ./darknet/darknet detector test cfg/anet.data cfg/${cfg_name}.cfg $weight "~/data/$image" -ext_output -dont_show >${log}
        fi
    done

done



