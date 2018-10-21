#!/bin/bash

filename=$(wget --no-check-certificate --content-disposition -nv $1 2>&1 |cut -d\" -f2)

uploadid=$(g upload $filename --share | sed -n -e 's/^.*id=//p' | sed -n -e 's/&.*$//p')
rm $filename

viewlink="https://drive.google.com/open?id=$uploadid"
downlink="https://drive.google.com/uc?id=${uploadid}&export=download"

if [ -n "$uploadid" ]
then
    echo $viewlink
    echo $downlink
fi
