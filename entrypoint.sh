#!/bin/sh

gw="$(hostname -i|awk -F. '{print $1"."$2"."$3".1"}')"
mkdir -p /usr/lib/firefox/browser/defaults/preferences/
echo 'user_pref("network.proxy.socks", "'"$gw"'");' > /usr/lib/firefox/browser/defaults/preferences/all-custom.js
echo 'user_pref("network.proxy.socks_port", 3333);' >> /usr/lib/firefox/browser/defaults/preferences/all-custom.js
echo 'user_pref("network.proxy.socks_remote_dns", true);' >> /usr/lib/firefox/browser/defaults/preferences/all-custom.js
echo 'user_pref("network.proxy.type", 1);' >> /usr/lib/firefox/browser/defaults/preferences/all-custom.js
echo 'user_pref("network.trr.mode", 2);' >> /usr/lib/firefox/browser/defaults/preferences/all-custom.js
echo 'pref("network.proxy.socks", "'"$gw"'");' >> /usr/lib/firefox/browser/defaults/preferences/all-custom.js
echo 'pref("network.proxy.socks_port", 3333);' >> /usr/lib/firefox/browser/defaults/preferences/all-custom.js
echo 'pref("network.proxy.socks_remote_dns", true);' >> /usr/lib/firefox/browser/defaults/preferences/all-custom.js
echo 'pref("network.proxy.type", 1);' >> /usr/lib/firefox/browser/defaults/preferences/all-custom.js
echo 'pref("network.trr.mode", 2);' >> /usr/lib/firefox/browser/defaults/preferences/all-custom.js

USER=firefox
USERID=1000
echo "creating new $USER with UID $USERID"
useradd -m $USER -u $USERID 
chown -R $USER /home/$USER
cd /home/$USER 
su $USER -c "firefox --profile=/tmp/.c --private-window"
