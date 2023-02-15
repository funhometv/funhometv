#!/bin/sh
#can also work with "python2 reloadcmd.py"
cat >/storage/.kodi/apache/apply_status  <<EOF
{
	"status": "Complete"
}
EOF
systemctl restart apache2

exit 0
