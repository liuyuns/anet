#!/bin/bash

word=$1

if [ "$word" == "" ]; then
  word=profile
fi

echo "Showing appearancies of word: '$word' in detection result files."
echo ""

for f in output/*; do
  word_count=$( cat $f | grep "$word" | wc -l )

  echo "# in $f : $word_count"

done

