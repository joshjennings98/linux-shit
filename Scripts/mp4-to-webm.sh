#!/bin/bah

name=$(echo "$1" | cut -f 1 -d '.')

ffmpeg  -i $name.mp4  -b:v 0  -crf 30  -pass 1  -an -f webm /dev/null
ffmpeg  -i $name.mp4  -b:v 0  -crf 30  -pass 2  $name.webm
