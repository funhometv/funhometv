#!/bin/sh
#can also work with "python2 reloadcmd.py"
cat >/storage/.kodi/apache/apply_status  <<EOF
{
	"status": "Complete"
}
EOF
systemctl restart apache2
systemctl restart avahi-daemon

cat >/storage/.kodi/apache/report2user.py <<EOF
import socket

try:
    sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    sock.connect('/var/run/service.funhometv.settings.sock')
    sock.send(b'certapplied')
    sock.close()
except Exception as e:
    print("oops , something wrong")
EOF
python3 /storage/.kodi/apache/report2user.py

exit 0
