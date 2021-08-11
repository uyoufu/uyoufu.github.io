---
layout: post
category: 佳软
title: Filezilla 安装及配置教程
tagline: by 明不知昔
tags: 
  - 佳软
published: true
---

本文为 FileZilla的安装教程及其配置，主要是方便今后快速搭建一个 Ftp 服务器。

<!--more-->

## 下载

- 通过 scoop 安装

  `scoop install extras/scoop install filezilla-server`

- 从官网下载

  也可以直接从官网下载安装

## FileZilla 配置

### 设置管理界面密码

![](https://i.loli.net/2021/08/10/pwIu6XDF7aMjNYW.png)

修改 FTP 管理端口，增强安全性，比如：20001，同时设置管理密码。设置管理界面密码是为了提高 FTP 的安全性，防止其他人修改 FTP 配置。

### 修改通信端口

![image-20210810142154949](https://i.loli.net/2021/08/10/bq1ZXiMzGhBTWDN.png)

FileZilla 的默认通信端口是 21，需要将其改成其它端口，提高安全性。

### 设置主动模式端口

![image-20210810114551377](https://i.loli.net/2021/08/10/a14EVkeP5dGbNhY.png)

设置端口范围，至少需要两个端口。该端口用于文件上传下载的数据传输。

### 配置 TLS

![image-20210810142603777](https://i.loli.net/2021/08/10/JHx6iTcPWuUDs52.png)

按步骤生成证书即可。

生成完成后，还需要修改TLS端口为自定义的端口，提高安全性。

## 防火墙配置

上述配置完成后，即可在本机进行连接使用，但是如果想在其它机器连接，则需要在安装电脑上的防火墙中添加入站规则，允许FTP相关的端口通过。上面的端口包括：

- 通信端口（默认21）
- 文件上传下载端口（默认1-65535）
- TLS 验证端口（默认990）

