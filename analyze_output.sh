#!/bin/bash

pattern=$1
shift
if [ "$pattern" == "" ]; then 
  pattern=* 
fi

word=$1
if [ "$word" == "" ]; then
  word=profile
fi

echo "Showing appearancies of word: '$word' in detection result files matching $pattern."
echo ""

for f in output/*$pattern*; do
  word_count=$( cat $f | grep "$word" | wc -l )

  echo "# in $f : $word_count"

done

