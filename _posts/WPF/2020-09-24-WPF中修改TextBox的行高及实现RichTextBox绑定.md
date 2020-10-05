---
layout: post
category: WPF
title: WPF中修改TextBox的行高及实现RichTextBox绑定
tagline: by 明不知昔
tags: 
  - WPF
  - TextBox
published: true
---

在 WPF 中，有时需要利用 TexTBox 来多行展示数据，但是，它默认的行高太丑，需要我们自己定义。

<!--more-->

设置如下属性即可：

``` c#
<TextBox TextBlock.LineHeight="10" TextBlock.LineStackingStrategy="BlockLineHeight" /> 
```

当然，也有可能会用 RichTextBox，这就不会有这个问题，但是 WPF 的富文本不能进行 Text 绑定，所以在 MVVM 中，用起来很难受。

幸好，有一个扩展可以解决这个问题，它叫 [wpftoolkit](https://github.com/xceedsoftware/wpftoolkit/wiki/RichTextBox)

用法如下：

``` xml
<toolkit:RichTextBox x:Name="_richTextBox" Grid.Row="1" Margin="10" BorderBrush="Gray" Padding="10"
                                          Text="{Binding Notes}" 
                                          ScrollViewer.VerticalScrollBarVisibility="Auto" />
```

