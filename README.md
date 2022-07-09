# Cloudreve-Script
Cloudreve全自动安装脚本，只需通过脚本即可傻瓜式安装、升级和管理cloudreve。<br>
Cloudreve fully automatic only with one click installation, upgrade and management script.

TG通知：https://t.me/cloudreve_script_notifications<br>
TG notification：https://t.me/cloudreve_script_notifications
## 正式版 （稳定可用）(v2.1.0) / Official version (stable and available) (v2.1.0)

```shell
wget -N --no-check-certificate https://raw.githubusercontent.com/UbiquityTony/Cloudreve-Script/main/official.sh && bash official.sh
```
## 补丁 / patch
```shell
wget -N --no-check-certificate https://github.com/UbiquityTony/Cloudreve-Script/releases/download/1.1.0/patch.sh && bash patch.sh
```
中文版安装教程/Chinese installation tutorial<br>
这是中文版教程，英文版在下面↓↓/ This is the Chinese version of the tutorial, and the English version is below ↓↓<br>
不懂cloudreve的请先到这里了解一下：https://cloudreve.org

准备：
1.服务器（vps）   2.ssh软件

开始安装：
1.连接服务器（vps），这里用putty示范。
[![图片1](https://speedcloud.cf/api/v3/file/source/43406/1.png?sign=VtFLliTwsKX2UUwYRvHV56Xz9GJj-yPmTOlgNQsclbU%3D%3A0)](https://speedcloud.cf/api/v3/file/source/43406/1.png?sign=VtFLliTwsKX2UUwYRvHV56Xz9GJj-yPmTOlgNQsclbU%3D%3A0)

2.运行Cloudreve-Script安装脚本。<br>
正式版 （稳定可用）(v2.1.0)

```shell
Wget -N --no-check-certificate https://raw.githubusercontent.com/UbiquityTony/Cloudreve-Script/main/official.sh && bash official.sh
```
等待执行完毕，直到这样：

一定要成功获取红圈处的版本号，否则无法继续安装。<br>
接下来按任意键继续，按CURL+C退出安装。

3.这时候就选择是从机模式还是主机模式了。输入“M”或“m”就选择安装从机模式，输入“S”或“s”就选择安装主机模式。具体区别可参考：


4.现在选择cloudreve安装命令，必须以/开头，必须是有效目录，按自己需求选择，直接enter则使用默认安装目录/data/cloudreve_community_master安装。


5.然后选择运行端口，必须在1-65535之间，可以输入enter使用默认端口5212。


6.最后选择下载节点，有5个节点选择（以后可能会更多），用户根据服务器（vps）选择较近的节点，各个节点的可用情况请根据实际情况查看。<br>
注：显示Unavailable为不可用，显示Available为可用。<br>
各节点信息：<br>
Node 1：Github原始地址（位置不知道，国外很快，国内速度不行）<br>
Node 2：Github镜像地址（速度、位置同上）<br>
Node 3：站长vps（地点在欧洲，建议欧洲服务器（vps）安装）<br>
Node 4：阿里云oss储存（地点在美国弗吉尼亚）<br>
Node 5：Onedrive（地点在美国）<br>
输入1/2/3/4/5选择节点。


7.按下任意键即可开始安装，只需静等安装完成就行了……

Cloudreve-Script主程序安装完毕，下面安装宝塔（因为Cloudreve-Script需要nginx，现在暂时没有这个技术，只能通过宝塔安装nginx）

8.输入宝塔安装命令安装宝塔。
Centos安装脚本

```shell
yum install -y wget && wget -O install.sh http://download.bt.cn/install/install_6.0.sh && sh install.sh ed8484bec
```
Ubuntu/Deepin安装脚本

```shell
wget -O install.sh http://download.bt.cn/install/install-ubuntu_6.0.sh && sudo bash install.sh ed8484bec
```
Debian安装脚本

```shell
wget -O install.sh http://download.bt.cn/install/install-ubuntu_6.0.sh && bash install.sh ed8484bec
```
万能安装脚本

```shell
if [ -f /usr/bin/curl ];then curl -sSO https://download.bt.cn/install/install_panel.sh;else wget -O install_panel.sh https://download.bt.cn/install/install_panel.sh;fi;bash install_panel.sh ed8484bec
安装方法请见宝塔面板下载。
```

9.安装好宝塔之后，进入宝塔，点击“软件商店”。


10.安装nginx。


11.配置cloudreve域名。


12、反向代理<br>
   我懒得写了，你自己看着办

以上就全部安装完毕了，尽情使用Cloudreve吧！
