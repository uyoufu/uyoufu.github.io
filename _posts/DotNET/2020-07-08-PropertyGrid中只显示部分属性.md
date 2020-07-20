---
layout: post
category: .NET
title: PropertyGrid 中只显示部分属性
tagline: by 明不知昔
tags: 
  - .NET
  - C#
published: true
---

在使用 PropertyGrid 控件中，有这样一个需求：需要将部分属性隐藏，只显示我们关心的部分属性，或者说，根据需求，要动态显示属性。

<!--more-->

原始的 在属性上面添加 特性 	`[Browsable(false)]` 肯定是不满足要求的。

我们可以采取下面的方式：