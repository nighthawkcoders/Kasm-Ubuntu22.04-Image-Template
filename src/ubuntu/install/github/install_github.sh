#!/usr/bin/env bash
set -ex

apt-get update
wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'

sudo apt update && sudo apt install github-desktop

cp /usr/share/applications/github-desktop.desktop $HOME/Desktop/
chmod +x $HOME/Desktop/github-desktop.desktop
chown 1000:1000 $HOME/Desktop/github-desktop.desktop