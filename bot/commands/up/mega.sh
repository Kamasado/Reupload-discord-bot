#!/bin/bash

filename=$(wget --no-check-certificate --content-disposition -nv $1 2>&1 |cut -d\" -f2)

m put $filename mega:/reuploads/
rm $filename

link=$(megals /Root/reuploads/ -e --reload | grep $filename | awk '{print $1}')

echo $link
