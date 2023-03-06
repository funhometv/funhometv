# FunHomeTV
[English](README.md)
把我们自己的云现在搬回家。

FunHomeTV让我们在家通过网络安全且方便地把手机上的照片和录像传输或备份到自己的存储盘上。从技术上说，它有一个Nextcloud服务端用于我们的Nextcloud客户端。我们的数据属于我们，并且存储在我们自己的设备上。空间大小只受我们硬盘的大小限制。在本地享用我们的照片和视频。让家有更多快乐。

## 如何使用

* 作为电脑上的虚拟机:

- 在“Releases”中下载"FunHomeTV-Generic.x86_64-1.0.2.ova.torrent"文件。先用浏览器下载它，然后使用ＢＴ下载ＯＶＡ文件，ＢＴ客户端可以使用 [qbittorrent](https://www.qbittorrent.org) 或 [transmission](https://transmissionbt.com/) 或者其他您选择使用的。然后[下载您使用的操作系统对应的 VMWare Workstation Player](https://www.vmware.com/go/downloadplayer) （推荐使用版本１５。不但文件小，而且比新版稳定，纯属个人看法）。使用它打开虚拟机ＯＶＡ文件，按照屏幕上向导操作直到结束。
- 在您手机的应用市场中下载 Nextcloud 。可能有的安卓手机需要从[F-DROID](https://f-droid.org)下载。 
- 使用下载的Nextcloud客户端程序扫描屏幕上的二维码，获取用户名／密码和服务器地址。
- 第一次使用Nextcloud服务端的时候，我们需要使用浏览器打开服务端的地址。我们可以在扫描二维码后，从Nextcloud手机客户端中选中地址栏，复制服务端的地址，而不需要通过打字输入地址。使用浏览器打开服务端地址后，可以设置用户名称和密码。请记得要更改用户“ｎｃ”的默认密码。
- 然后在Nextcloud客户端中，选择需要上传的照片和录像的文件夹。
- 其他用户可以通过浏览器页面在Nextcloud服务端上建立和设置。
- 注意：作为自由软件，涉及域名、证书、数据库以及网络，我们使用我们自己服务器，有时候可能需要点耐心。特别是第一次连接到服务端的时候。可能服务端在第一次访问的时候需要进行初始化，后面就工作正常了。

* 作为一台物理的机器，它需要定制。 连接手机、电脑和电视。

## 要求
* 作为虚拟机，需要虚拟机软件。例如：对于Windows 或者 Linux，需要[VMWare Workstation Player](https://www.vmware.com/go/downloadplayer) ，　macOS 需要[VMWare fusion](https://www.vmware.com/products/fusion.html) 。 
* 至少有１Ｇ内存可供虚拟机使用。在测试中发现至少需要２Ｇ内存。 
* 虚拟机需要和您的手机在一个无线局域网或者有线局域网，这样手机才能和虚拟机中的FunHomeTV服务连接，除非我们配置了其他网络设置。
* 以上主机环境需要６４位。

## 对开发人员
* 请参照 [Libreelec.tv](https://libreelec.tv) 网站了解开发过程。
* 在克隆funhometv之后，注意funhometv的默认分支是"product"，而不是"master"/"main"。
* 我们需要在编译前下载nextcloud hub的压缩包，把它放在packages/network/nextcloud/conffiles目录中。这个压缩包直到服务器第一次启动才解压缩。

## FunHomeTV 从哪里分叉而来?
* FunHomeTV 从 LibreELEC 分叉而来, 还安装了apache2 ( 2.4.x ) / php (7.3.x) / mariadb (10.3.x) / nextcloud (25.0.x) / acme.sh (3.0.x) 等。 

**问题与支持**

请通过[LibreELEC forum: Bug Reports](https://forum.libreelec.tv/forum-35.html)反映问题。请在Please ask support questions in the [LibreELEC forum: Help & Support](https://forum.libreelec.tv/forum-3.html)问问题并获取支持，或者在Freenode中　#libreelec　上向项目的成员请教。对于中文问题，请在　[智能电视网](https://www.znds.com/forum.php) 发布关于FunHomeTV的帖子。　或者向 e 点 hao 在 aol 点 com 发邮件, 请不要希望能够很快获得回复。

**捐赠**

向libreelec捐献以资助基金的目的，可以通过PayPal向 donations@libreelec.tv 发送。 对于 FunHomeTV , 请向 uucoin 在 163 点 com 发送。

**许可证**

LibreELEC original code is released under [GPLv2](https://www.gnu.org/licenses/gpl-2.0.html). So do FunHomeTV.

**版权**

As LibreELEC/FunHomeTV includes code from many upstream projects it includes many copyright owners. LibreELEC/FunHomeTV makes NO claim of copyright on any upstream code. However all original LibreELEC/FunHomeTV authored code is copyright LibreELEC/FunHomeTV. Patches to upstream code have the same license as the upstream project, unless specified otherwise. For a complete copyright list please checkout the source code to examine license headers. Unless expressly stated otherwise all code submitted to the FunHomeTV project (in any form) is licensed under [GPLv2](https://www.gnu.org/licenses/gpl-2.0.html) and copyright is donated to LibreELEC/FunHomeTV. This approach allows the project to stay manageable in the long term by giving us freedom to maintain the code as part of the whole without the management overhead of preserving contact with every submitter, e.g. GPLv3. You are absolutely free to retain copyright. To retain copyright simply add a copyright header to each submitted code page. If you submit code that is not your own work it is your responsibility to place a header stating the copyright.
