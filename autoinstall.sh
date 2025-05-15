curl -s https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /etc/apt/trusted.gpg.d/google.gpg
echo deb [arch=amd64] https://dl.google.com/linux/chrome-remote-desktop/deb stable main >>/etc/apt/sources.list.d/chrome-remote-desktop.list
echo deb [arch=amd64] https://dl.google.com/linux/chrome/deb stable main >>/etc/apt/sources.list.d/chrome.list
apt-get -qq -o DPkg::Lock::Timeout=60 update
DEBIAN_FRONTEND=noninteractive apt-get -qq -o DPkg::Lock::Timeout=60 install desktop-base xscreensaver dbus-x11 xfce4 task-xfce-desktop less bzip2 zip unzip tasksel wget chrome-remote-desktop google-chrome-stable
# https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#:~:text=disable%20the%20display%20manager
# https://zenn.dev/google_cloud_jp/articles/chrome-remote-desktop#:~:text=colord
systemctl disable lightdm colord
# https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#choose_a_different_desktop_environment
echo exec /etc/X11/Xsession /usr/bin/xfce4-session >/etc/chrome-remote-desktop-session
