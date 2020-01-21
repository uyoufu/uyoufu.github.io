---
layout: post
category: MVVM
title: WPF MVVM Stylet使用文档（中文）-Home
tagline: by 明不知昔
tags: 
  - WPF
  - MVVM
published: true
---

在 Github 上发现一个开源轻巧的 MVVM 框架，发现网上缺少相应的中文文档，便进行了翻译总结，英文水平有限，MVVM也才初学，若有错误，还请斧正。

<!--more-->



Stylet 是一个小巧，但强大的 MVVM 框架，它的灵感来自于 [Caliburn.Micro](https://caliburnmicro.com/)。*它通过进一步减少复杂性和各种事件*，让不熟悉任何 MVVM 框架的人(同事)更快地使用 MVVM 框架。



它还提供了在 Caliburn.Micro 里没有的功能。包括独有的【IoC容器】，更简单的【 ViewModel验证】和兼容 mvvm 的消息框架。



少量的代码（LOC : Line Of Code）和非常全面的测试组件使得 Sytlet 对于那些使用、验证或确认 SOUP 导致高开销的项目是一个很有吸引力的选择。Stylet 的模块化 toolkit-inspired 架构意味着它很容易让你自由使用，使用你喜欢的部分,或替掉你不喜欢的部分。



下面是一个简洁的特点列表。也可以点击链接了解更多信息。



## [视图模型优先（A ViewModel-First apporach）](https://github.com/canton7/Stylet/wiki/ViewModel-First)



典型的 MVVM 结构：视图（View）知道如何实例化它的视图模型（ViewModel），而 ViewModel 通常不直接通信，这种结构被称之为 视图优先（View-First）。然而，反转这个模式——使用者自己实例化 ViewModels，然后框架自动将 View 附加到实例化的 ViewModel 上——这种方式有很多优点，它允许你以一种非常熟悉的方式组合ViewModels。这种 ViewModel-First 方式是 Stylet 唯一支持的。 



## [响应（Action）]()

