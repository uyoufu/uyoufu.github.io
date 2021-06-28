---
layout: post
category: mongoose
title: monoose返回对象无法比较ObjectId
tagline: by 明不知昔
tags: 
  - mongodb
  - mongoose
  - js
published: true
---

在使用 `mongoose` 时遇到这样一个坑，`Schema` 定义如下：

``` json
{
    // id
    _id: {
      type: mongoose.Types.ObjectId,
      required: true,
    },

    // 部门名称
    departmentName: {
      type: String,
      trim: true,
      required: true,
    },

    // 描述
    description: String,

    // 排序
    order: Number,

    // 上一级部门
    parentId: {
      type: mongoose.Types.ObjectId,
      required: true,
    },
};
```

当我使用`===`比较集合中两个 ObjectId 时，始终为 `false` 。

<!--more-->

这是我的比较语句的主要部分：

``` json
const departments = await this.ctx.mode('Department').find({})

const firstDp = departments[0]

const parentDp = departments.find(dp=>dp._id===firstDp.parentId)

console.log("result:",parentDp===null)
// result:true
```

在查找第一个部门的父部门时，始终找不到（父部门是存在的）。

后面通过排查，才发现，原来通过 `find()` 查找出来的对象是 `mongoose` 自己的包装过的对象，上面的 `_id` 和 `parentId` 也是一个`ObjectId`对象，所以直接用 `===` 比较时，始终返回 `false`，导致不能找到结果。

找到问题的原因后，直接将 `ObjectId` 转成字符串比较就可以了。

``` json
const parentDp = departments.find(dp=>dp._id.toString()===firstDp.parentId.toString())

console.log("result:",parentDp===null)
// result:false
```

