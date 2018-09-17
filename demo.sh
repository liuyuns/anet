#!/bin/bash
name=$(basename ${1%.*})

echo $name


./darknet/darknet detector test cfg/anet_v1.data cfg/anet-tiny-default-anchor-test.cfg backup/anet-tiny-default-anchor_2800.weights $1


mv prediction* predict_$name.jpg
