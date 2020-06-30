---
layout: post
category: 佳软
title: 使用 AdGuardHome，实现网页加速和去广告
tagline: by 明不知昔
tags: 
  - 佳软
  - Adguard
published: true
---

![adguard](https://camo.githubusercontent.com/1b7e7c20e5f4d52f70c7e25726e75825ee26d767/68747470733a2f2f63646e2e616467756172642e636f6d2f7075626c69632f416467756172642f436f6d6d6f6e2f616467756172645f686f6d652e7376673f73616e6974697a653d74727565)

## 前言

最近有一款软件深深地吸引了我，界面如下：

![adguard1](https://camo.githubusercontent.com/5e2bfa17c27773b70ca99ddd3b70995f15d24b62/68747470733a2f2f63646e2e616467756172642e636f6d2f7075626c69632f416467756172642f436f6d6d6f6e2f616467756172645f686f6d652e676966)

它的主要功能有三项

- 通过对 dns 的并发查询来加速网页的打开速度，大部分可以实现秒开
- 通过不同的规则来过滤 dns，达到过滤广告的目的，最厉害的是，国内的各大视屏网站的广告也能过滤，看剧再也不用等待那漫长的 70s 了
- 通过设置过滤器，可以很好的保护自己的上网安全，防止钓鱼网站等的危害

这三个特点完全戳中了我的兴趣点，而且它的界面清爽，让人不得不喜欢。

<!--more-->

## 选择困难症

AdGuard 在各个平台上都有相应的 App，直接下载来用就可以了，但是，这些平台的软件都有一个问题，它们不能进行 dns 的加速，真是让人郁闷不已。

在谷歌上搜 AdGuardHome, 大家的食用方法基本分为这两派：

- 安装在软件路由，NAS等设备上面
- 通过购买云服务器，构建 dns 服务器

我不禁呵呵了，上面两个方案，哪一个不需要花钱啊！

最后，结合实际，我总结出了自己的一个使用方法，在此分享给大家：在电脑上安装 AGuardHome 作为本机的 dns 服务器，只要用电脑上网，就能实现加速，当然，也可以实现全局域网的加速，后面详细介绍。

## 下载软件

该软件是开源的，所以，只需要到 GitHub 上下载符合自己的系统的版本就可以了。本教程将以 windows10 来举例说明。

开源仓库地址：https://github.com/AdguardTeam/AdGuardHome

软件下载地址：https://github.com/AdguardTeam/AdGuardHome/releases

## 安装软件

- 将下载的软件解压，比如 `D:\Program Files\AdGuardHome`;

- 用 **管理员权限** 启动 cmd(命令提示符) 窗口

  在任务栏中的搜索框中键入 cmd, 会出现一个名为 “命令提示符” 的程序，右键，用管理员身份打开；

- 在打开的黑窗体中依次输入下面的代码

  ```
  d:
  cd D:\Program Files\AdGuardHome
  AdGuardHome
  ```

  输入最后一个命令后，当黑窗体中出现如下截图的提示信息的时候，表示初始化已经成功了。

## 注册 windows 服务

打开 cmd 窗口，输入下面的命令来注册系统服务，以便开机自动启动：

```
d:
cd D:\Program Files\AdGuardHome
AdGuardHome -s install
```

此处一并放上其它的命令，如果有需要，可以使用

```
AdGuardHome -s uninstall //卸载 AdGuardHome 服务
AdGuardHome -s start //开始服务
AdGuardHome -s stop //结束服务
AdGuardHome -s restart //重启服务
AdGuardHome -s status //显示服务状态
```



## AdGuardHome 配置

到现在 AdGuardHome 已经安装完成 ，接下来，在浏览器中输入地址：http://127.0.0.1:3000 进行配置。

### 基本设置

- 配置管理员接口和 DNS 服务

  ![adminInterface](https://user-images.githubusercontent.com/5947035/53299867-25407b00-3851-11e9-96fc-44d9a10813db.png)

  上图中，第一个端口是管理界面的访问端口，如果将端口 XX，那今后访问 AdGuardHome 的管理界面就变成: http://127.0.0.1:XX, 建议设置成 3000。

  第二个端口是 DNS 服务监听端口，使用默认的就可以了，如果使用其它端口，在使用时，还需要额外指定端口号，稍微繁琐，所以建议直接用默认的就可以了。

- 添加用户名和密码

  ![addUsers](https://user-images.githubusercontent.com/5947035/53299876-3ee1c280-3851-11e9-81da-a5126729ff2e.png)

  > 注意：设置后，在界面里是没有修改用户名和密码的选项的，需要修改配置文件，所以，在添加用户名和密码的时候，不要太随意。

### DNS 设置

在设置->DNS 设置 里，对 DNS 进行配置

![dns](https://i.loli.net/2020/06/24/bOVZzCg6Qdv9ohA.png)

- 上游 DNS 服务器中输入：

    ```
    8.8.8.8
    114.114.114.114
    119.29.29.29
    223.5.5.5
    180.76.76.76
    1.2.4.8
    ```

- 打开 “并行请求”

- 在 Bootstrap DNS 中输入：

  ```
  9.9.9.10
  149.112.112.10
  2620:fe::10
  2620:fe::fe:10
  ```

- 点击应用

## 添加过滤器

过滤器的作用是通过一些预定义的规则来过滤 DNS，从而达到去除广告，保护隐私的目的。

过滤器的添加是在：过滤器->DNS 封锁清单 里面

推荐的规则有：

- AdGuard Simplified Domain Names filter, 自带

- AdAway, 自带
- MalwareDomainList.com Hosts List，自带
- AdGuard Base filter，https://filters.adtidy.org/extension/chromium/filters/2.txt
- AdGuard Tracking Protection filter，https://filters.adtidy.org/extension/chromium/filters/3.txt
- AdGuard Annoyances filter，https://filters.adtidy.org/extension/chromium/filters/14.txt
- anti-ad-easylist，https://raw.githubusercontent.com/privacy-protection-tools/anti-AD/master/anti-ad-easylist.txt

当然，网上有特别多的规则，大家可以在 bilibili 或者 github 上面搜索。

## 修改网络适配器 DNS 实现所有网络下的加速

好了，到目前为止，我们已经在自己的电脑上安装了 AdGuardHome 了，接下来，配置电脑本机的 DNS，让它指向我们自己的 DNS 服务器，实现网页访问加速和隐私保护。

- 打开网络适配器

  在 `控制面板\所有控制面板项\网络连接` 选择自己当前的网络适配器

  右键->属性-> 双击 `Internet 协议版 4(TCP/IPv4)`

- 使用自定义 DNS

  如下图

  ![p1](https://i.loli.net/2020/06/30/e8lo2uAwjRNTg6z.png)

这样，就完成了配置，可以尽情地享受快速无广告的冲浪体验了。

## 修改路由器 DNS 实现局域网加速

上面的设置，只能够让自己使用网络加速功能，如果要想在局域网里面让所有的终端都能够实现网络加速，我们可以将安装了 AdGuardHome 服务的电脑当成局域网中的 DNS 服务器，这样，只要有人连接了你的局域网，他就会享受到加速。但是这有两个缺点：

- 安装 DNS 服务的电脑必须一直开着机
- 如果局域网内的终端很多，可能会影响 DND 服务的那台电脑

当然，如果是家庭里面使用，就完全不用担心了。

下面是具体的步骤：

- 查看自己的局域网网关

  ![p3](https://i.loli.net/2020/06/30/WLVT5aGZOndHNgt.png)

  打开网络设置，找到 IPv4 地址，网关一般都是 `网段.1`,上面我们可以看到，本机的 IP4 是 192.168.3.29, 所以网段就是前面三个值，而网关为 192.168.3.1

- 将自己电脑设置为静态 IP

  选择网络，然后编辑，打开 IPv4,然后按照下面的配置输入

![p2](https://i.loli.net/2020/06/30/nbTcwpryAUv49HQ.png)

因为我的网段是 192.168.3，所心，我输入的 IP 地址也必须是在这个网段内，范围是2~255，当前例子中，使用的是 192.168.3.100

- 打开路由器管理界面，开启静态 DNS

  ![p4](https://i.loli.net/2020/06/30/KVJsgh6CGkUwLOe.png)

  将路由器的首选 DNS 指向安装了 DNS 服务的电脑就可以了。

## 后记

对于加速，没怎么感受到，但是网页确实干净了不少。