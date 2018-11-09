#!/bin/bash

num=$1
shift
w=$1
shift
h=$1
shift

if [ "$h" == "" ]; then
echo ""
echo "Usage: "
echo "    $0 [num of clusters] [width] [height] [args for darknet(optional)]"
echo ""

exit 1

fi

./darknet/darknet detector calc_anchors cfg/anet.data -num_of_clusters $num -width $w -height $h $*
