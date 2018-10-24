#!/bin/bash

echo $2

if [ $2 = folder ]
then
    folder=carpeta_`date '+%d-%m_%H%M%S'`
    mkdir $folder
    megadl --path $folder "$1"
    g upload $folder --recursive
    rm -rf $folder
    uploadid=$(g list --service-account drive.json | grep $folder | awk '{print $1}')
    g share $uploadid
else
    filename=$(megadl "$1" | grep Downloaded | awk '{print $2}')
    uploadid=$(g upload $filename --share --delete --service-account drive.json | sed -n -e 's/^.*id=//p' | sed -n -e 's/&.*$//p')
fi

viewlink="https://drive.google.com/open?id=$uploadid"
downlink="https://drive.google.com/uc?id=${uploadid}&export=download"

if [ -n "$uploadid" ]
then
    echo $viewlink
    echo $downlink
fi
