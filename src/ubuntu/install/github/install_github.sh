#!/usr/bin/env bash
set -ex

# Add the GitHub package repository
wget -qO - https://packagecloud.io/shiftkey/desktop/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/shiftkey/desktop/any/ any main" > /etc/apt/sources.list.d/packagecloud-shiftky-desktop.list'

# Update the package list
sudo apt-get update

# Install GitHub Desktop
sudo apt-get install github-desktop

# add to desktop
cp /usr/share/applications/github-desktop.desktop $HOME/Desktop/
chown 1000:1000 $HOME/Desktop/github-desktop.desktop
chmod +x $HOME/Desktop/github-desktop.desktop

# add to path
mv /usr/bin/github-desktop /usr/bin/github-desktop-orig
cat >/usr/bin/github-desktop <<EOL
#!/usr/bin/env bash
exec /usr/share/github-desktop/github-desktop \$@
EOL
chmod +x /usr/bin/github-desktop
