---
layout: post
category: js
title: javalscript 中的原型来源和理解
tagline: by 明不知昔
tags: 
  - js
published: true
---

一直不能很好的理解 javascrip 的原型，个人认为它的原型有些反人类直觉，所以让人不是很好理解，所以特意抽时间整理了下。

<!--more-->

## 为什么用原型来实现继承

我一直存在这样一个疑惑，既然 js 提供了对象，为什么不能提供像 C#、Javal 这种语言中对象的继承特性，而是要靠原型来实现，让我开始接触时，产生了不解和抵触。
直到我看到了这篇文章：[Javascript继承机制的设计思想](http://www.ruanyifeng.com/blog/2011/06/designing_ideas_of_inheritance_mechanism_in_javascript.html) 才恍然大悟。

javascrip 设计者 Brendan Eich，他的主要方向和兴趣是函数式编程。再加上当时**网景公司的整个管理层，都是Java语言的信徒，Sun公司完全介入网页脚本语言的决策。**

所以，**Javascript语言实际上是两种语言风格的混合产物----（简化的）函数式编程+（简化的）面向对象编程。**这是由Brendan Eich（函数式编程）与网景公司（面向对象编程）共同决定的。

javascript 的设计思路为：

1. 借鉴C语言的基本语法；

2. 借鉴Java语言的数据类型和内存管理；

3. 借鉴Scheme语言，将函数提升到"第一等公民"（first class）的地位；

4. 借鉴[Self语言](http://en.wikipedia.org/wiki/Self_(programming_language))，使用基于原型（prototype）的继承机制。

由于 Javascript 借鉴了 Java 里的设计思想，javascrip 里面都是对象，所以必须有一种机制，将所有对象联系起来。最后，Brendan Eich设计了基于原型的"继承"。

## 怎么理解原来及原型链

原型及原型链的理解可以参考：[一张图搞定JS原型&原型链](https://segmentfault.com/a/1190000021232132)

## 参考

1. [Javascript继承机制的设计思想](http://www.ruanyifeng.com/blog/2011/06/designing_ideas_of_inheritance_mechanism_in_javascript.html)
2. [Javascript诞生记](http://www.ruanyifeng.com/blog/2011/06/birth_of_javascript.html)
3. [一张图搞定JS原型&原型链](https://segmentfault.com/a/1190000021232132)