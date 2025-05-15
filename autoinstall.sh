echo deb [arch=amd64] https://dl.google.com/linux/chrome-remote-desktop/deb stable main | tee -a /etc/apt/sources.list.d/chrome-remote-desktop.list
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes desktop-base xscreensaver dbus-x11 xfce4 task-xfce-desktop less bzip2 zip unzip tasksel wget chrome-remote-desktop
systemctl disable lightdm.service
echo exec xfce4-session > /etc/chrome-remote-desktop-session

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt-get install --assume-yes --fix-broken google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

echo Chrome remote desktop installation completed