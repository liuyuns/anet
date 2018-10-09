#!/bin/bash

./darknet/darknet detector calc_anchors cfg/anet.data -num_of_clusters 6 -width 608 -height 608
