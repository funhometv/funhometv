#!/bin/sh
nextcloud_fix_perm(){
#echo "in nextcloud_fix_perm"
	# make nextcloud not to check permissions and stop to report 770 needed.
	#'check_data_directory_permissions' => false,
	if [ -e  /storage/nextcloud/config/autoconfig.php -a `grep check_data_directory_permissions /storage/nextcloud/config/autoconfig.php| wc -l` == "0" ]; then
		sed -i "s|);|\n 'check_data_directory_permissions' => false,\n);\n|" /storage/nextcloud/config/autoconfig.php
#echo "after 1 sed"
	fi
	if [ ! -e /storage/nextcloud/config/autoconfig.php  ]; then 
		if [  -e /storage/nextcloud/config/config.php  -a `grep check_data_directory_permissions /storage/nextcloud/config/config.php| wc -l` == "0"  ]; then
			sed -i "s|);|\n 'check_data_directory_permissions' => false,\n);\n|" /storage/nextcloud/config/config.php
#echo "after 2 sed"
		fi
	fi
#echo "end next_fix_perm"
}

we_mount_and_fix_perm(){
#echo "we mount and fix"
	vmhgfs-fuse .host:/ /mnt/hgfs -o allow_other -o uid=65532 -o gid=65532
	#RETURN=$?
	#if [ ! $RETURN -eq 0 ]; then
	#	exit $RETURN
	#fi
	mkdir -p /mnt/hgfs/`vmware-hgfsclient`/nextcloud
	mkdir -p /mnt/hgfs/`vmware-hgfsclient`/immich
	mount -o bind /mnt/hgfs/`vmware-hgfsclient`/nextcloud  /storage/nextclouddata
	mount -o bind /mnt/hgfs/`vmware-hgfsclient`/immich /storage/immichdata

}
notify_mounted(){
#echo "notify mount"
    cat >/storage/.kodi/apache/report2usermounted.py <<EOF
import socket

try:
    sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    sock.connect('/var/run/service.funhometv.settings.sock')
    sock.send(b'mounted')
    sock.close()
except Exception as e:
    print("oops , something wrong")
EOF
    python3 /storage/.kodi/apache/report2usermounted.py
   
}

#echo "nextcloud _ fix _ perm"
nextcloud_fix_perm

#echo "start check_share_folder_mounted_by_us"
#check_share_folder_mounted_by_us 
if [ `mount|grep nextclouddata| wc -l` == "1" ]; then
# already mounted
#echo "we already mounted"
	exit 1
fi
#echo "start check folder user add"
if [ `vmware-hgfsclient| wc -l` == "0" ]; then 
	echo "user not add shared folder"
	exit 1
fi
# user not add a share folder for vm
#echo "start check share folder mounted by vmtools"
if [ `mount|grep mnt| wc -l` == "0" ]; then
# vmtoolsd not mount the user shared folder
#echo "vmtoolsd not mount the user shared folder"
        we_mount_and_fix_perm 
	notify_mounted
        exit 0
elif [ `mount|grep mnt| wc -l` == "1" ]; then
# vmtoolsd mounted , should not for daemon , we change it to belong daemon.
#echo "vmtoolsd mounted , but we need to unmount first"
        umount /mnt/hgfs
        we_mount_and_fix_perm
	notify_mounted
        exit 0
fi
#echo "end"

