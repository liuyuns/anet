#!/bin/bash

cfg_name=$1
shift

weight=$1
shift

w_h=$1
if [ "$w_h" == "" ]; then
  w_h=1
fi

if [ "$weight" == "" ];
    then
    echo ""
    echo "  Usage:"
    echo "    $0 [cfg_name] [weight_file] [width/height ratio]"
    echo "      [cfg_name], e.g. yolov3-anet, anet-icons"
    echo "      [weight_file], e.g. backup/yolov3-anet_20xx.weights"
    echo "      [width/height ratio] e.g. 16/28"

    exit  1
fi

test_images=( "Android_2_Pro_Cart_Input_Cart.png" "IOS_2_Pro_Cart_Input_Button.png" "Web_2_Pro_Cart_Ham.png" "IOS_3_Button_Input_Ham.png")

[ -d output ] || mkdir output

cfg_file=cfg/test-${cfg_name}.cfg

base_name=`basename $weight`

log_prefix="output/${base_name}"

# from 8*32 to 20 * 32, (256-640)
for scale in {8..20}; do
    let "size = ${scale} * 32"
    let "height = ${scale} * ${w_h} * 32 "
    echo "Size: ${size}"
    sed -i s"/width=.*/width=${size}/g" $cfg_file
    sed -i s"/height=.*/height=${height}/g" $cfg_file

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
