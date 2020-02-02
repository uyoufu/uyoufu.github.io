---
layout: post
category: MVVM
title: WPF MVVM Stylet使用文档（中文）08-事件聚合器（The EventAggregator）
tagline: by 明不知昔
tags: 
  - WPF
  - MVVM
published: true
---



## 简介

事件聚合器——EventAggregator——是一个分散的、弱绑定的、基于发布/订阅的事件管理器。

<!--more-->

## 发布者和订阅者（Publishers and Subscribers）

### 订阅者（Subscribers）

对特定事件感兴趣的订阅者可以将自己的兴趣告诉 IEventAggregator，并且每当发布者将特定事件发布到IEventAggregator 时，都会收到通知。

事件是类——可以用它们做任何你想做的事情。例如:

<table><tr><td>C#</td><td>VB.NET</td>
<tr><td valign="top"><pre lang="csharp">
class MyEvent { 
&nbsp;
  // Do something 
&nbsp;
}</pre>
</td><td valign="top"><pre lang="vb.net">
Class MyEvent
&nbsp;
  &#39; Do Something
&nbsp;
End Class</pre></td></tr></table>

订阅者必须实现 `IHandle<T> `，其中 `T` 是他们感兴趣的事件类型 (当然，他们可以实现多个 `IHandle<T>` 's for多个 `T` 's)。然后他们必须获得 IEventAggregator 的实例，并订阅自己，例如:

<table><tr><td>C#</td><td>VB.NET</td>
<tr><td valign="top"><pre lang="csharp">
class Subscriber : IHandle&lt;MyEvent&gt;, IHandle&lt;MyOtherEvent&gt;
{
   public Subscriber(IEventAggregator eventAggregator)
   {
      eventAggregator.Subscribe(this);
   }
&nbsp;
   public void Handle(MyEvent message)
   {
      // ...
   }
&nbsp;
   public void Handle(MyOtherEvent message)
   {
      // ...
   }
}</pre>
</td><td valign="top"><pre lang="vb.net">
Class Subscriber : Implements IHandle(Of MyEvent)
&nbsp;
  Public Sub New(ByRef eventAggregator as IEventAggregator)
  eventAggregator.Subscribe(Me)
  End Sub
&nbsp;
  Public Sub Handle(message as MyEvent) Implements IHandle(Of MyEvent).Handle
  &#39; ...
  End Sub
&nbsp;
  Public Sub Handle(message as MyOtherEvent) Implements IHandle(Of MyOtherEvent).Handle
  &#39; ...
  End Sub
&nbsp;
End Class</pre></td></tr></table>

VB.NET 用户，通过引用传递 eventAggregator 的' Sub New() '可能会在名称空间间失败，而且必须为每个新订阅服务器定义可能会令人恼火。因此，在全局模块中定义eventAggregator，然后直接订阅它，而不是将其引用传递给调用的每个新ViewModel，可能更容易。