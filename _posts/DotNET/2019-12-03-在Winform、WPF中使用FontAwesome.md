---
layout: post
category: .NET
title: 在 Winform、WPF 中使用 Font Awesome
tagline: by 明不知昔
tags: 
  - .NET
  - C#
published: true
---
![aa](https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1575367038265&di=c1b4abb41c717a4beded451e572b88ba&imgtype=jpg&src=http%3A%2F%2Fimg1.imgtn.bdimg.com%2Fit%2Fu%3D3016701716%2C3766993118%26fm%3D214%26gp%3D0.jpg)
今天在 github 上发现了一个可以在 Winform、WPF 中使用 Font Awesome 的项目。

<!--more-->

项目地址：https://github.com/seayxu/FontAwesome

## 开发环境

Windows 10 + Visual Studio 2013 + .NetFramework 3.5

## 功能

将 FontAwesome 图标生成图片和 Icon 图标

## 使用

> 可以在 Windows Forms 和 WPF 程序中使用。

*  添加类库，可以通过 nuget 安装。

> PM Install-Package FontAwesomeNet

* 添加 FontAwesomeNet 命名空间：FontAwesomeNet。

* 示例

```
// get FontAwesome icon class names(type is Dictionary<string, int>)
string[] names = FontAwesome.TypeDict.Select(v => v.Key).ToArray();

// use FontAwesome icon class name get FontAwesome icon Unicode value
int val = FontAwesome.TypeDict["fa-heart"];//0xf004

// defalut:
Bitmap bmp = FontAwesome.GetImage(val);//0xf004
Icon ico = FontAwesome.GetIcon(val);//0xf004

// custom:
FontAwesome.IconSize = 128;//change icon size
FontAwesome.ForeColer = Color.Purple;//change icon forecolor
Bitmap bmp = FontAwesome.GetImage(val);//0xf004
Icon ico = FontAwesome.GetIcon(val);//0xf004
```

## 协议

 [MIT License](https://github.com/seayxu/FontAwesome/blob/master/LICENSE) 

*如有问题，欢迎指出。*

## 致谢

本文转载于:[ https://my.oschina.net/sesametech/blog/1542840 ]( https://my.oschina.net/sesametech/blog/1542840 )

