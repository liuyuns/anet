#!/bin/bash

./darknet/darknet detector calc_anchors cfg/anet.data -num_of_clusters 9 -width 416 -height 416
