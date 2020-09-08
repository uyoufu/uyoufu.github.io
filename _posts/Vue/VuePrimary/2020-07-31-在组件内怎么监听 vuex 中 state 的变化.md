---
layout: post
category: vue
title: 在组件内怎么监听 Vuex 中 state 的变化
tagline: by 明不知昔
tags: 
  - vue
published: true
---

最近在项目中需要使用 Vuex 来维护一个全局字段，同时在子组件里需要根据该字段的变化向后端请求数据来展示。

<!--more-->

有两个办法解决上面的问题：

- 用 computed 属性

本方案有个缺陷，就是如果在组件内的模板区域内没有使用该计算属性，它是不会响应 state 中值的变化的，而本项目就遇到了这个坑，后面采用下面的方法解决了。

- 用 watch 属性

直接 watch state 里面的属性值，这里也有一个注意的地方，不能使用 lamda 表达式，而是要使用完整的方法定义，见下面的代码：

``` js
watch: {
    '$store.getters.loginedProjectGroupId': function(value) {
      this.getProjectInfo(value)
    }
  },
```
