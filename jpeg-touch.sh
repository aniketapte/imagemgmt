#!/bin/bash

# Finds all files in the current directory whose names end with 'jpg', retrieve
# date & time of creation from the EXIF, and 'touch' the file with that date/time
#
# Needs exif
# 'apt-get install exif' on Ubuntu
# 'brew install exif' on Mac

jpegs=$(find . -type f | grep -i jpg$ | awk -F"/" {' print $2 '})
if [[ "x${jpegs}" == "x" ]]; then
    echo "No image files found."
    exit 0
fi

IFS=$'\n'
for j in ${jpegs}
do
    tstamp=$(exif "${j}" | grep 'Date and Time (Origi' | awk -F"|" {' print $2 '} | sed 's@[: ]@@g')
    #echo "tstamp='${tstamp}'"
    touch_tstamp="${tstamp:0:12}.${tstamp:12:2}"
    #echo "touch -t ${touch_tstamp} \"${j}\""
    touch -t ${touch_tstamp} "${j}"
done
