---
layout: post
category: MySql
title: MySql scoop 安装
tagline: by 明不知昔
tags: 
  - MySql
published: true
---

为了方便今后安装 mysql，特对 scoop 安装 MySql 的流程记录一下。

<!--more-->

## 安装程序

```
scoop install mysql
```

## 配置服务

根据 scoop 提示，运行 mysqld 命令

```
mysqld --install MySQL --defaults-file="D:\scoop\apps\mysql\current\my.ini"
```

## 运行服务

用管理员方式启动命令行窗口，在里面输入：

```
net start MySQL
```

## 修改密码

打开命令行，输入

```
mysql -u root
```

然后再设置密码

```
SET PASSWORD FOR 'root'@'localhost' = 'auth_string';
```