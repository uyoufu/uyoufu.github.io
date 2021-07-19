---
layout: post
category: mongoose
title: mongoose使用findOneAndUpdate不能更新默认值
tagline: by 明不知昔
tags: 
  - mongodb
  - mongoose
  - js
published: true
---

今天遇到这样一个问题，当我使用 `findOneAndUpdate` 来更新或新建文档时，发现如果文档是新建的，则定义的默认值居然为空。

经过查阅相关文档，在查询时添加 `setDefaultsOnInsert: true` 可以解决这个问题。

``` javascript
{
  upsert: true,
  new: true,
  // 在插入时设置默认值
  setDefaultsOnInsert: true,
}
```

