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

cfg_file=cfg/test-${cfg_name}.cfg

while true
do
    weight=$( ls backup/${cfg_name}* -t | head -1 )
    if [ "$weight" == "$last_weight" ];
        then 
        echo "Same weight, sleep 1m until next check...."
        sleep 2m
        continue
    fi

    last_weight=$weight

    base_name=`basename $weight`

    log_prefix="output/${base_name}"

    # from 8*32 to 20 * 32, (256-640)
    for scale in {8..20}; do
        let "size = ${scale} * 32"
        echo "Size: ${size}"
        sed -i s"/width=.*/width=${size}/g" $cfg_file
        sed -i s"/height=.*/height=${size}/g" $cfg_file

        cat $cfg_file | head -9

        for image in "${test_images[@]}"
        do
            echo "Run detection for ${image}"
            if [ "$eval_script" == "" ];
            then
            ./darknet/darknet detector test cfg/anet.data $cfg_file $weight ~/data/$image -ext_output -dont_show >>${log_prefix}_${size}.log
            fi
        done
    done
done



