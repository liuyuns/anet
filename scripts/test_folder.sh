#!/bin/bash

cfg_name=$1
shift

folder=$1
shift

args=$*

if [ "$folder" == "" ]; then
script_name=`basename $0`
echo ""
echo "Usage: $script_name [cfg_name] [image_folder]"
echo ""
exit 1
fi

weight=$( ls models/${cfg_name}* -t | head -1 )

if [ "$weight" == "" ]; then
    echo "Weight file not found under backup folder!!!"
    exit 1
fi

script_dir=`dirname $0`

for file in $folder/*.png $folder/*.jpg
do
    if [ ! -f "$file" ]; then
       continue
    fi

    printf "File to test: %s \n\n" $file
    file_name=`basename $file .png`
    file_name=`basename $file_name .jpg`

    $script_dir/test_image.sh $cfg_name $weight $file "predict_$file_name" $args
     
done
