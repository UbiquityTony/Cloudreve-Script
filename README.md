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

# 中文版安装教程/Chinese installation tutorial<br>
这是中文版教程，英文版在下面↓↓/ This is the Chinese version of the tutorial, and the English version is below ↓↓

不懂cloudreve的请先到这里了解一下：https://cloudreve.org<br>

准备：
1.服务器（vps）   2.ssh软件（WindTerm、putty等）

开始安装：
1.连接服务器（vps），这里用putty示范。
[![图片1](https://speedcloud.cf/api/v3/file/source/43406/1.png?sign=VtFLliTwsKX2UUwYRvHV56Xz9GJj-yPmTOlgNQsclbU%3D%3A0)](https://speedcloud.cf/api/v3/file/source/43406/1.png?sign=VtFLliTwsKX2UUwYRvHV56Xz9GJj-yPmTOlgNQsclbU%3D%3A0)

2.运行Cloudreve-Script安装脚本。<br>
正式版 （稳定可用）(v2.1.0)

```shell
wget -N --no-check-certificate https://raw.githubusercontent.com/UbiquityTony/Cloudreve-Script/main/official.sh && bash official.sh
```
输入后，会自动安装依赖，遇到"E"不要慌，忽略即可。等待执行完毕，直到这样：
[![图片2](https://speedcloud.cf/api/v3/file/source/43405/2.png?sign=koSgz3BfNU2virLNz00EDSa-c2BS-ZPC-y_qkgGfDZc%3D%3A0)](https://speedcloud.cf/api/v3/file/source/43405/2.png?sign=koSgz3BfNU2virLNz00EDSa-c2BS-ZPC-y_qkgGfDZc%3D%3A0)<br>
注意：一定要成功获取红圈处的版本号，否则无法继续安装。<br>
     获取失败请尝试按CTRL+C退出安装重新运行）<br>
     如果你是小白，可以一直按回车键，使用默认配置即可。<br>
     接下来按任意键继续，按CTRL+C退出安装。

3.选择cloudreve模式
这时候就选择是从机模式还是主机模式了。输入“M”或“m”就选择安装从机模式，输入“S”或“s”就选择安装主机模式。
[![图片3](https://speedcloud.cf/api/v3/file/source/43407/3.png?sign=LInqdyTWkh2S1V0n7ulm6kJFet6fkTbfre7pPcmsFVk%3D%3A0)](https://speedcloud.cf/api/v3/file/source/43407/3.png?sign=LInqdyTWkh2S1V0n7ulm6kJFet6fkTbfre7pPcmsFVk%3D%3A0)

4.选择cloudreve安装路径
必须以/开头，必须是绝对路径，按自己需求选择，直接enter则使用默认安装目录/data/cloudreve _community_master安装。<br>
[![图片4](https://speedcloud.cf/api/v3/file/source/43408/4.png?sign=WkVsw0Yxv_lVnSxhJmZG_0WdmhrE7oEFLpPAysLwYKI%3D%3A0)](https://speedcloud.cf/api/v3/file/source/43408/4.png?sign=WkVsw0Yxv_lVnSxhJmZG_0WdmhrE7oEFLpPAysLwYKI%3D%3A0)

5.选择运行端口
端口必须在1-65535之间，可以输入enter使用默认端口5212。
[![图片5](https://speedcloud.cf/api/v3/file/source/43409/5.png?sign=U77Hcnq6fzCMGknnkCrBoEdbCatJt1rfcpELDD3QRuA%3D%3A0)](https://speedcloud.cf/api/v3/file/source/43409/5.png?sign=U77Hcnq6fzCMGknnkCrBoEdbCatJt1rfcpELDD3QRuA%3D%3A0)

6.最后选择下载节点
目前有5个节点选择（以后可能会更多），用户根据服务器（vps）选择较近的节点，各个节点的可用情况请根据实际情况查看。<br>
注：显示Unavailable为不可用，显示Available为可用。<br>
各节点信息：<br>
Node 1：Github原始地址（位置不知道，国外很快，国内速度不行）<br>
Node 2：Github镜像地址（速度、位置同上）<br>
Node 3：站长vps（地点在欧洲，建议欧洲服务器（vps）安装）<br>
Node 4：阿里云oss储存（地点在美国弗吉尼亚）<br>
Node 5：Onedrive（地点在美国）<br>
输入1/2/3/4/5选择节点。
[![图片6](https://speedcloud.cf/api/v3/file/source/43410/6.png?sign=X1Q9fvAf2Mp3wFartbsC1mV_yfRlLvJuPxSwEOT2t_A%3D%3A0)](https://speedcloud.cf/api/v3/file/source/43410/6.png?sign=X1Q9fvAf2Mp3wFartbsC1mV_yfRlLvJuPxSwEOT2t_A%3D%3A0)

7.按下任意键即可开始安装，只需静等安装完成就行了……

Cloudrev主程序安装完毕！

8、反向代理<br>
在自用或者小规模使用的场景下，你完全可以使用 Cloudreve 内置的 Web 服务器。但是如果你需要使用 HTTPS，亦或是需要与服务器上其他 Web 服务共存时，你可能需要使用主流 Web 服务器反向代理 Cloudreve ，以获得更丰富的扩展功能。<br>
你需要在 Web 服务器中新建一个虚拟主机，完成所需的各项配置（如启用 HTTPS），然后在网站配置文件中加入反代规则：

Nginx：<br>
在网站的server字段中加入：<br>

```shell
location / {
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect off;
    proxy_pass http://127.0.0.1:5212;

    # 如果您要使用本地存储策略，请将下一行注释符删除，并更改大小为理论最大文件尺寸
    # client_max_body_size 20000m;
}
```
Apache：<br>
在VirtualHost字段下加入反代配置项ProxyPass，比如：<br>

```shell
<VirtualHost *:80>
    ServerName myapp.example.com
    ServerAdmin webmaster@example.com
    DocumentRoot /www/myapp/public

    # 以下为关键部分
    AllowEncodedSlashes NoDecode
    ProxyPass "/" "http://127.0.0.1:5212/" nocanon

</VirtualHost>
```
IIS：<br>
1. 安装 IIS URL Rewrite 和 ARR 模块<br>
URL Rewrite: <a href="https://www.iis.net/downloads/microsoft/url-rewrite#additionalDownloads">点击下载</a><br>
ARR: <a href="https://www.iis.net/downloads/microsoft/application-request-routing#additionalDownloads">点击下载</a><br>
如已安装，请跳过本步。<br>
2. 启用并配置 ARR<br>
打开 IIS，进入主页的 Application Request Routing Cache，再进入右边的 Server Proxy Settings...，勾选最上面的 Enable proxy，同时取消勾选下面的 Reverse rewrite host in response headers。点击右边的 应用 保存更改。<br>
进入主页最下面的 配置编辑器 (Configuration Editor)，转到 system.webServer/proxy 节点，调整 preserveHostHeader 为 True 后点击右边的 应用 保存更改。<br>
如果不取消勾选反向重写主机头，会导致 Cloudreve API 无法返回正确的地址，导致无法预览图片视频等。<br>
3. 配置反代规则<br>
这是 web.config 文件的内容，将它放在目标网站根目录即可。此样例包括两个规则与一个限制：<br>
HTTP to HTTPS redirect (强制 HTTPS，需要自行配置 SSL 后才可使用，不使用请删除该 rule)<br>
Rerwite (反代)<br>
requestLimits 中的 60000000 为传输文件大小限制，单位 byte，如果您要使用本地存储策略请更改大小为理论最大文件尺寸<br>

```shell
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <system.webServer>
        <rewrite>
            <rules>
                <rule name="HTTP to HTTPS redirect" stopProcessing="true">
                    <match url=".*" />
                    <conditions logicalGrouping="MatchAll" trackAllCaptures="false">
                        <add input="{HTTPS}" pattern="off" />
                    </conditions>
                    <action type="Redirect" url="https://{HTTP_HOST}/{R:0}" redirectType="Permanent" />
                </rule>
                <rule name="Rerwite" stopProcessing="true">
                    <match url=".*" />
                    <conditions logicalGrouping="MatchAny" trackAllCaptures="false">
                        <add input="{REQUEST_FILENAME}" matchType="IsFile" negate="true" />
                        <add input="{REQUEST_FILENAME}" matchType="IsDirectory" negate="true" />
                    </conditions>
                    <action type="Rewrite" url="http://localhost:5212/{R:0}" />
                </rule>
            </rules>
        </rewrite>
        <security>
            <requestFiltering allowDoubleEscaping="true">
                <requestLimits maxAllowedContentLength="60000000" />
            </requestFiltering>
        </security>
    </system.webServer>
</configuration>
```

### 以上就全部安装完毕了，尽情使用Cloudreve吧！


# Installation tutorial in English/英文版安装教程<br>
For those who don't understand cloudrev, please come here first to understand: https://cloudreve.org<br>

get ready:<br>
1.Server (VPS)     2.SSH software (windterm, putty, etc.)

Start installation:<br>
1.Connect to the server (VPS). Putty is used here for demonstration. 
[![图片1](https://speedcloud.cf/api/v3/file/source/43406/1.png?sign=VtFLliTwsKX2UUwYRvHV56Xz9GJj-yPmTOlgNQsclbU%3D%3A0)](https://speedcloud.cf/api/v3/file/source/43406/1.png?sign=VtFLliTwsKX2UUwYRvHV56Xz9GJj-yPmTOlgNQsclbU%3D%3A0)

2.Run the cloudrev script installation script<br>
Official version (stable and available) (v2.1.0)

```shell
wget -N --no-check-certificate https://raw.githubusercontent.com/UbiquityTony/Cloudreve-Script/main/official.sh && bash official.sh
```
After entering, the dependency will be automatically installed. Don't panic when encountering "e", just ignore it. Wait until the execution is completed:<br>
[![图片2](https://speedcloud.cf/api/v3/file/source/43405/2.png?sign=koSgz3BfNU2virLNz00EDSa-c2BS-ZPC-y_qkgGfDZc%3D%3A0)](https://speedcloud.cf/api/v3/file/source/43405/2.png?sign=koSgz3BfNU2virLNz00EDSa-c2BS-ZPC-y_qkgGfDZc%3D%3A0)<br>
Note: the version number in the red circle must be obtained successfully, otherwise the installation cannot continue<br>
Failed to get. Please try to press ctrl+c to exit the installation and run again)<br>
If you are Xiaobai, you can press enter all the time and use the default configuration<br>
Next, press any key to continue, and press ctrl+c to exit the installation. 

3.Select cloudrev mode<br>
At this time, it is time to choose slave mode or master mode. Enter "m" or "m" to select the installation slave mode, and enter "s" or "s" to select the installation master mode. 
[![图片3](https://speedcloud.cf/api/v3/file/source/43407/3.png?sign=LInqdyTWkh2S1V0n7ulm6kJFet6fkTbfre7pPcmsFVk%3D%3A0)](https://speedcloud.cf/api/v3/file/source/43407/3.png?sign=LInqdyTWkh2S1V0n7ulm6kJFet6fkTbfre7pPcmsFVk%3D%3A0)

4.Select the cloudrev installation path<br>
It must start with / and must be an absolute path. You can choose according to your needs. If you enter directly, you will use the default installation directory /data/cloudrev_community_Master installation<br>
[![图片4](https://speedcloud.cf/api/v3/file/source/43408/4.png?sign=WkVsw0Yxv_lVnSxhJmZG_0WdmhrE7oEFLpPAysLwYKI%3D%3A0)](https://speedcloud.cf/api/v3/file/source/43408/4.png?sign=WkVsw0Yxv_lVnSxhJmZG_0WdmhrE7oEFLpPAysLwYKI%3D%3A0)

5.Select the operation port<br>
The port must be between 1-65535. You can enter enter to use the default port 5212. 
[![图片5](https://speedcloud.cf/api/v3/file/source/43409/5.png?sign=U77Hcnq6fzCMGknnkCrBoEdbCatJt1rfcpELDD3QRuA%3D%3A0)](https://speedcloud.cf/api/v3/file/source/43409/5.png?sign=U77Hcnq6fzCMGknnkCrBoEdbCatJt1rfcpELDD3QRuA%3D%3A0)

6.Finally, select the download node<br>
At present, there are five nodes to choose (there may be more in the future). The user selects the nearest node according to the server (VPS). Please check the availability of each node according to the actual situation<br>
Note: if unavailable is displayed, it means unavailable; if available is displayed, it means available<br>
Information of each node:<br>
Node 1:github original address (location unknown, foreign fast, domestic speed not)<br>
Node 2: GitHub image address (speed and location are the same as above)<br>
Node 3: webmaster VPS (located in Europe, it is recommended to install European server (VPS)<br>
Node 4: Alibaba cloud OSS storage (located in Virginia, USA)<br>
Node 5:onedrive (located in the United States)<br>
Enter 1/2/3/4/5 to select a node. 
[![图片6](https://speedcloud.cf/api/v3/file/source/43410/6.png?sign=X1Q9fvAf2Mp3wFartbsC1mV_yfRlLvJuPxSwEOT2t_A%3D%3A0)](https://speedcloud.cf/api/v3/file/source/43410/6.png?sign=X1Q9fvAf2Mp3wFartbsC1mV_yfRlLvJuPxSwEOT2t_A%3D%3A0)

7.Press any key to start the installation. Just wait for the installation to complete……

Cloudrev main program is installed!

8.Reverse proxy<br>
In the scenario of self use or small-scale use, you can use the built-in web server of cloudrev. However, if you need to use HTTPS or coexist with other web services on the server, you may need to use cloudrev, a mainstream web server reverse proxy, to obtain richer extension functions<br>
You need to create a new virtual host in the web server, complete the required configurations (such as enabling HTTPS), and then add anti substitution rules to the website configuration file: 

Nginx：<br>
Add:<br>

```shell
location / {
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect off;
    proxy_pass http://127.0.0.1:5212;

    # If you want to use the local storage policy, delete the next line of comment and change the size to the theoretical maximum file size
    # client_max_body_size 20000m;
}
```
Apache：<br>
Add the reverse configuration item proxypass under the virtualhost field, for example:<br>

```shell
<VirtualHost *:80>
    ServerName myapp.example.com
    ServerAdmin webmaster@example.com
    DocumentRoot /www/myapp/public

    # The following are the key parts
    AllowEncodedSlashes NoDecode
    ProxyPass "/" "http://127.0.0.1:5212/" nocanon

</VirtualHost>
```
IIS：<br>
1. Install IIS URL Rewrite and arr modules<br>
URL Rewrite: <a href=" https://www.iis.net/downloads/microsoft/url-rewrite#additionalDownloads"> click download </a><br>
ARR: <a href=" https://www.iis.net/downloads/microsoft/application-request-routing#additionalDownloads"> click download </a><br>
If installed, please skip this step<br>
2. Enable and configure arr<br>
Open IIS, enter the application request routing cache on the home page, and then enter the server proxy settings on the right, Check enable proxy at the top and uncheck reverse rewrite host in response headers below. Click Apply on the right to save the changes<br>
Enter the configuration editor at the bottom of the home page and go to systemOn the webserver/proxy node, adjust the preservehostheader to true and click the application on the right to save the changes<br>
If you do not uncheck the reverse rewrite host header, the cloudrev API will not be able to return the correct address, resulting in the inability to preview pictures and videos<br>
3. Configure anti substitution rules <br>
This is webThe contents of the config file can be placed in the root directory of the target website. This example includes two rules and one restriction:<br>
HTTP to HTTPS redirect (HTTPS is mandatory. You need to configure SSL yourself before using it. If not, please delete this rule)<br>
Rerwitte (reverse substitution) <br>
60000000 in requestlimits is the size limit of the transferred file, in bytes. If you want to use the local storage policy, please change the size to the theoretical maximum file size<br>

```shell
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <system.webServer>
        <rewrite>
            <rules>
                <rule name="HTTP to HTTPS redirect" stopProcessing="true">
                    <match url=".*" />
                    <conditions logicalGrouping="MatchAll" trackAllCaptures="false">
                        <add input="{HTTPS}" pattern="off" />
                    </conditions>
                    <action type="Redirect" url="https://{HTTP_HOST}/{R:0}" redirectType="Permanent" />
                </rule>
                <rule name="Rerwite" stopProcessing="true">
                    <match url=".*" />
                    <conditions logicalGrouping="MatchAny" trackAllCaptures="false">
                        <add input="{REQUEST_FILENAME}" matchType="IsFile" negate="true" />
                        <add input="{REQUEST_FILENAME}" matchType="IsDirectory" negate="true" />
                    </conditions>
                    <action type="Rewrite" url="http://localhost:5212/{R:0}" />
                </rule>
            </rules>
        </rewrite>
        <security>
            <requestFiltering allowDoubleEscaping="true">
                <requestLimits maxAllowedContentLength="60000000" />
            </requestFiltering>
        </security>
    </system.webServer>
</configuration>
```

### The above is all installed. Enjoy cloudreve!

