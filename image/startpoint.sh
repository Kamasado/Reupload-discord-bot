#!/bin/bash

echo dk12 | sudo -S echo -- Authorized sudo --
echo "kamasado:$SSHPASS" | sudo chpasswd
sudo /etc/init.d/ssh start

sed -i -e "s/{USER}/$USER/" ~/.megarc
sed -i -e "s/{PASS}/$PASS/" ~/.megarc

sed -i -e "s/{USER}/$USER/" ~/.megacmd.json
sed -i -e "s/{PASS}/$PASS/" ~/.megacmd.json

mkdir /home/kamasado/.gdrive
echo $DRIVE > /home/kamasado/.gdrive/drive.json

screen -dm -S "sshport" autossh -M 0 -o ServerAliveInterval=60 -o StrictHostKeyChecking=no -R $SSHPORT:localhost:26 serveo.net
yarn start
