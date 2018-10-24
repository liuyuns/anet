#!/bin/bash

cfg_name=$1

if [ ! -f "cfg/$cfg_name.cfg" ]; then
  echo "cfg file not exist, please check and try again!"
  exit 1
fi

tmux new -s "train" -d
tmux send-keys -t "train" "./train.sh cfg/${cfg_name}.cfg -dont_show" C-m
tmux send-keys -t "train" "sudo shutdown -r +15" C-m

tmux new -s "eval" -d
tmux send-keys -t "eval" "./batch_eval.sh ${cfg_name}" C-m

tmux ls

echo "We are good to quit the ssh session, and leave it run and shutdown by itself"
