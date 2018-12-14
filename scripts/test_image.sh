#!/bin/bash

echo "Args: $*"
echo ""

cfg_name=$1
shift

weight=$1
shift

image=$1
shift

out_image=$1
shift

if [[ "$weight" == "" ||   "$image" == "" ]];
    then
    echo ""
    echo "  Usage:"
    echo "    $0 [cfg_name] [weight_file] [image] [out_image(optional)]"
    echo "      [cfg_name], e.g. yolov3-anet, anet-icons"
    echo "      [weight_file], e.g. backup/yolov3-anet_20xx.weights"
    echo "      [image], the image file to test, e.g. ~/data/test.png"
    echo "      [out_image(optional)], optional path to save the result image"
    echo ""

    exit  1
fi

[ -d output ] || mkdir output

cfg_file=cfg/${cfg_name}.cfg

weight_name=`basename $weight .weights`

extra_args=$(if [ "$out_image" != "" ]; then echo "-out output/${out_image}_${weight_name}";  else echo ""; fi)

exe_args="$cfg_file $weight $image $extra_args $*"

# echo "Args for detector test: $exe_args"


if [ -f "./darknet/darknet" ]; then    
    ./darknet/darknet detector test cfg/anet.data $exe_args 2>nul
else
    echo "Args for detector test: $exe_args"
    echo ""
fi

