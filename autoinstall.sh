mkdir -p /usr/share/X11/xorg.conf.d
tee /usr/share/X11/xorg.conf.d/10-headless.conf << 'EOF'
Section "Device"
    Identifier "VirtualDevice"
    Driver     "dummy"
    VideoRam   256000
EndSection

Section "Monitor"
    Identifier "VirtualMonitor"
    HorizSync  30.0-62.0
    VertRefresh 50.0-70.0
    Modeline "1920x1080_60.00" 172.80 1920 2040 2248 2576 1080 1081 1084 1118
EndSection

Section "Screen"
    Identifier "DefaultScreen"
    Device     "VirtualDevice"
    Monitor    "VirtualMonitor"
    DefaultDepth 24
    SubSection "Display"
        Depth     24
        Modes     "1920x1080_60.00"
    EndSubSection
EndSection
EOF

curl -s https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /etc/apt/trusted.gpg.d/google.gpg
echo deb [arch=amd64] https://dl.google.com/linux/chrome-remote-desktop/deb stable main >>/etc/apt/sources.list.d/chrome-remote-desktop.list
echo deb [arch=amd64] https://dl.google.com/linux/chrome/deb stable main >>/etc/apt/sources.list.d/chrome.list
# https://lists.debian.org/deity/2024/04/msg00040.html
while fuser /var/lib/apt/lists/lock; do sleep 1; done
apt-get -qq update
DEBIAN_FRONTEND=noninteractive apt-get -qq -o DPkg::Lock::Timeout=-1 install desktop-base xscreensaver dbus-x11 xfce4 task-xfce-desktop less bzip2 zip unzip tasksel wget chrome-remote-desktop google-chrome-stable xserver-xorg-video-dummy xserver-xorg-input-libinput
# https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#:~:text=disable%20the%20display%20manager
# https://zenn.dev/google_cloud_jp/articles/chrome-remote-desktop#:~:text=colord
systemctl disable lightdm colord
# https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#choose_a_different_desktop_environment
echo exec /etc/X11/Xsession /usr/bin/xfce4-session >/etc/chrome-remote-desktop-session
# https://superuser.com/a/1153084
echo CHROME_REMOTE_DESKTOP_DEFAULT_DESKTOP_SIZES=1920x1080 >> /etc/environment
echo CHROME_REMOTE_DESKTOP_USE_XORG=1 >> /etc/environment
echo CHROME_REMOTE_DESKTOP_LOG_FILE=/tmp/crd.log >> /etc/environment
# Please setup at https://remotedesktop.google.com/headless
# DISPLAY=:0 google-chrome --no-first-run --no-default-browser-check --start-maximized --auto-open-devtools-for-tabs
# Disable ウィンドウに合わせてサイズ変更 on Chrome Remote Desktop Client
systemctl restart lightdm