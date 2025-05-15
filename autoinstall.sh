sleep 20
curl -s https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /etc/apt/trusted.gpg.d/google.gpg
echo deb [arch=amd64] https://dl.google.com/linux/chrome-remote-desktop/deb stable main >>/etc/apt/sources.list.d/chrome-remote-desktop.list
echo deb [arch=amd64] https://dl.google.com/linux/chrome/deb stable main >>/etc/apt/sources.list.d/chrome.list
apt-get -o DPkg::Lock::Timeout=-1 update
DEBIAN_FRONTEND=noninteractive apt-get -qq -o DPkg::Lock::Timeout=-1 install desktop-base xscreensaver dbus-x11 xfce4 task-xfce-desktop less bzip2 zip unzip tasksel wget chrome-remote-desktop google-chrome-stable
systemctl disable colord lightdm
echo exec /etc/X11/Xsession /usr/bin/xfce4-session >/etc/chrome-remote-desktop-session