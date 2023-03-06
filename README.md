# FunHomeTV
[中文版](README-SC.md)
Take our own cloud to home right now.
FunHomeTV make mobile backup or transfer photo and video at home thought network to our own storage secure and easy. Technically , it has a nextcloud server for our mobile nextcloud client . Our data belong to us , and stored with us . Size only limited by our disk size .  Enjoy our photo and video locally . Make home more fun. 

## How to use

* As a virtual machine on our computer:
- Download the FunHomeTV "FunHomeTV-Generic.x86_64-1.0.2.ova.torrent" in Releases, need to use browser download the torrent file first , then use a bittorrent client to download the ova file . Bittorrent client we can use [qbittorrent](https://www.qbittorrent.org) or [transmission](https://transmissionbt.com/) or other you selected to use . Then [download VMWare Workstation Player](https://www.vmware.com/go/downloadplayer) (version 15 is recommend , not only small in size , but also stable than newer version. -- pure personnel opinion )  for your computer's OS . Use it to Open the ova file . Follow the wizard on screen until end.
- Download Nextcloud mobile application in our mobile's application market. Maybe some android mobile need to download from [f-droid.org](https://f-droid.org).
- Scan the QRCode on the screen to link with our Nextcloud mobile client ,get user name / password and server address. 
- First time use the Nextcloud server side , we should use browser to open the server address . We can copy the server address from nextcloud mobile client's address bar after scan the QRCode , while not to type the server address in browser.  Use  browser to open the virtual machine's nextcloud address , setup up user name and password. Remember to change the default password of user "nc" .
- Then in nextcloud mobile client , select the directory of photo or video library to upload.
- Other user can be setup thought Nextcloud web interface.
- Note: As free software , and involve DNS & certificate & database and network , we use server at our own , there are sometime need be patient. Especially when first time connect to Nextcloud Hub . It maybe need initilized first time . Even we need use  browser to connect first time. Laterlly , it works .

* As a phyical machine , it's need to order . Connect mobile PC & TV .

## Requirement
* As a virtual machine need the virtual machine software , such as VMWare Workstation Player for Windows or Linux , and Fusion for macOS  , and VirtualBox on Windows or Linux or macOS. 
* At least 1G RAM free for the virtual machine . The host should at least 2G RAM in test . 
* The virtual machine should be on same WLAN/LAN with our mobile , so that our mobile can connect to the FunHomeTV service in virtual machine , except we setup other network settings. (Bridged is better, like another host on our LAN)
* Upper host machine OS should be 64-bit .

## For developer
* Please consult Libreelec.tv website to learn about the development process.
* After clone the branch of funhometv , note that , default branch of funhometv is "product" , not "master"/"main".
* We should download nextcloud hub in compressed package before build ,  put it in packages/network/nextcloud/conffiles. The nextcloud compressed package is not uncompressed until the server first started .


## Where FunHomeTV fork ?
* FunHomeTV is fork from LibreELEC , with web server apache2 ( 2.4.x ) / php (7.3.x) / mariadb (10.3.x) / nextcloud (25.0.x) / acme.sh (3.0.x) etc installed. 


**Issues & Support**

Please report issues via the [LibreELEC forum: Bug Reports](https://forum.libreelec.tv/forum-35.html). Please ask support questions in the [LibreELEC forum: Help & Support](https://forum.libreelec.tv/forum-3.html) or ask a member of project staff in the #libreelec IRC channel on Freenode.  For FunHomeTV , you can post at project's github issues page in english . For Chinese , at   https://www.znds.com/forum.php , post about FunHomeTV in other boxes . Or email  e dot hao at aol dot com , don't expect reply very soon.


**Donations**

Contributions towards current project funding goals can be sent via PayPal to donations@libreelec.tv . For FunHomeTV , donations to uucoin at 163 dot com .

**License**

LibreELEC original code is released under [GPLv2](https://www.gnu.org/licenses/gpl-2.0.html). So do FunHomeTV.

**Copyright**

As LibreELEC/FunHomeTV includes code from many upstream projects it includes many copyright owners. LibreELEC/FunHomeTV makes NO claim of copyright on any upstream code. However all original LibreELEC/FunHomeTV authored code is copyright LibreELEC/FunHomeTV. Patches to upstream code have the same license as the upstream project, unless specified otherwise. For a complete copyright list please checkout the source code to examine license headers. Unless expressly stated otherwise all code submitted to the FunHomeTV project (in any form) is licensed under [GPLv2](https://www.gnu.org/licenses/gpl-2.0.html) and copyright is donated to LibreELEC/FunHomeTV. This approach allows the project to stay manageable in the long term by giving us freedom to maintain the code as part of the whole without the management overhead of preserving contact with every submitter, e.g. GPLv3. You are absolutely free to retain copyright. To retain copyright simply add a copyright header to each submitted code page. If you submit code that is not your own work it is your responsibility to place a header stating the copyright.
